locals {
  context = var.context
}

# main.tf

# 创建镜像
module "openldap_image" {
  source = "git::http://172.20.14.17/jiajian.chi/terraform-zstack-image.git"

  create_image        = true
  image_name          = var.image_name
  image_url           = var.image_url
  guest_os_type      = "Centos 7"
  platform           = "Linux"
  format             = "qcow2"
  architecture       = "x86_64"
  expunge            = var.expunge

  backup_storage_name = var.backup_storage_name
}

# 创建虚拟机实例
module "openldap_instance" {
  source = "git::http://172.20.14.17/jiajian.chi/terraform-zstack-instance.git"

  name                  = var.instance_name
  description           = "OpenLDAP Server Created by Terraform"
  instance_count        = 1
  image_uuid            = module.openldap_image.image_uuid
  l3_network_name       = var.l3_network_name
  instance_offering_name = var.instance_offering_name

  expunge            = var.expunge
}

# 生成 docker-compose 文件
resource "local_file" "docker_compose" {
  content = templatefile("${path.module}/templates/docker-compose.yml.tpl", {
    ldap_organisation     = var.ldap_organisation
    ldap_domain           = var.ldap_domain
    ldap_base_dn          = var.ldap_base_dn
    ldap_admin_password   = var.ldap_admin_password
    ldap_config_password  = var.ldap_config_password
    ldap_readonly_user    = var.ldap_readonly_user
    ldap_readonly_username = var.ldap_readonly_username
    ldap_readonly_password = var.ldap_readonly_password
  })
  filename = "${path.module}/docker-compose.yml"
}

# 生成 Keycloak 初始化脚本
resource "local_file" "initial_schema" {
  content = templatefile("${path.module}/templates/initial_schema.ldif.tpl", {
    ldap_base_dn = var.ldap_base_dn
    ldap_groups  = var.ldap_groups
    ldap_users   = var.ldap_users
  })
  filename = "${path.module}/initial_schema.ldif"
}

# 上传 docker-compose 文件到实例
resource "terraform_data" "remote_exec" {
  depends_on = [module.openldap_instance, local_file.docker_compose, local_file.initial_schema]

  connection {
      type     = "ssh"
      host     = module.openldap_instance.instance_ips[0]
      user     = var.ssh_user
      password = var.ssh_password
      timeout  = "5m"
  }

  provisioner "file" {
    source      = "${path.module}/docker-compose.yml"
    destination = "/opt/openldap/docker-compose.yml"
    on_failure = fail
  }

  provisioner "file" {
    source      = "${path.module}/initial_schema.ldif"
    destination = "/opt/openldap/initial_schema.ldif"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Starting OpenLDAP services...'",
      "bash /opt/openldap/start-openldap.sh",
      "echo 'OpenLDAP services started successfully'"
    ]
    on_failure = fail
  }

}


