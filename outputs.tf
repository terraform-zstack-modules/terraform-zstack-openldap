#
# Contextual output
#

output "walrus_project_name" {
  value       = try(local.context["project"]["name"], null)
  description = "The name of project where deployed in Walrus."
}

output "walrus_project_id" {
  value       = try(local.context["project"]["id"], null)
  description = "The id of project where deployed in Walrus."
}

output "walrus_environment_name" {
  value       = try(local.context["environment"]["name"], null)
  description = "The name of environment where deployed in Walrus."
}

output "walrus_environment_id" {
  value       = try(local.context["environment"]["id"], null)
  description = "The id of environment where deployed in Walrus."
}

output "walrus_resource_name" {
  value       = try(local.context["resource"]["name"], null)
  description = "The name of resource where deployed in Walrus."
}

output "walrus_resource_id" {
  value       = try(local.context["resource"]["id"], null)
  description = "The id of resource where deployed in Walrus."
}

output "openldap_server_ip" {
  description = "OpenLDAP 服务器 IP 地址"
  value       = module.openldap_instance.instance_ips[0]
}

output "openldap_admin_dn" {
  description = "OpenLDAP 管理员 DN"
  value       = "cn=admin,${var.ldap_base_dn}"
}

output "openldap_admin_password" {
  description = "OpenLDAP 管理员密码"
  value       = var.ldap_admin_password
  sensitive   = true
}

output "phpldapadmin_url" {
  description = "phpLDAPadmin 访问 URL"
  value       = "http://${module.openldap_instance.instance_ips[0]}:8080"
}

output "ldap_connection_string" {
  description = "LDAP 连接字符串"
  value       = "ldap://${module.openldap_instance.instance_ips[0]}:389"
}

output "ldaps_connection_string" {
  description = "LDAPS 连接字符串"
  value       = "ldaps://${module.openldap_instance.instance_ips[0]}:636"
}

output "endpoints" {
  value = {
    phpldapadmin_url       =  "http://${module.openldap_instance.instance_ips[0]}:8080"
    ldap_connection_string = "ldap://${module.openldap_instance.instance_ips[0]}:389"
  }
}