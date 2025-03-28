#
# Contextual Fields
#

variable "context" {
  description = <<-EOF
Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.

Examples:
```
context:
  project:
    name: string
    id: string
  environment:
    name: string
    id: string
  resource:
    name: string
    id: string
```
EOF
  type        = map(any)
  default     = {}
}


# variables.tf

# 应用配置变量
variable "image_name" {
  description = "Name for the log server image"
  type        = string
  default     = "openldap-by-terraform"
}

variable "image_url" {
  description = "URL to download the image from"
  type        = string
  default     = "http://minio.zstack.io:9001/packer/openldap-by-packer-image-compressed.qcow2"
}

variable "backup_storage_name" {
  description = "Name of the backup storage to use"
  type        = string
  default     = "Ceph"
}

variable "instance_name" {
  description = "Name for the openldap server instance"
  type        = string
  default     = "openldap"
}

variable "l3_network_name" {
  description = "Name of the L3 network to use"
  type        = string
  default     = "test"
}

variable "instance_offering_name" {
  description = "Name of the instance offering to use"
  type        = string
  default     = "min"
}

variable "ssh_user" {
  description = "SSH username for remote access"
  type        = string
  default     = "root"
}

variable "ssh_password" {
  description = "SSH password for remote access"
  type        = string
  default     = "password"
  sensitive   = true
}


# OpenLDAP 基本配置
variable "ldap_organisation" {
  description = "LDAP 组织名称"
  type        = string
  default     = "Example Inc"
}

variable "ldap_domain" {
  description = "LDAP 域名"
  type        = string
  default     = "example.org"
}

variable "ldap_base_dn" {
  description = "LDAP Base DN"
  type        = string
  default     = "dc=example,dc=org"
}

variable "ldap_admin_password" {
  description = "LDAP 管理员密码"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "ldap_config_password" {
  description = "LDAP 配置密码"
  type        = string
  default     = "config"
  sensitive   = true
}

variable "ldap_readonly_user" {
  description = "是否创建只读用户"
  type        = bool
  default     = true
}

variable "ldap_readonly_username" {
  description = "LDAP 只读用户名"
  type        = string
  default     = "readonly"
}

variable "ldap_readonly_password" {
  description = "LDAP 只读用户密码"
  type        = string
  default     = "readonly"
  sensitive   = true
}

# LDAP 组配置
variable "ldap_groups" {
  description = "LDAP 组配置"
  type = list(object({
    name     = string
    gid      = number
  }))
  default = [
    {
      name = "users"
      gid  = 5000
    },
    {
      name = "admins"
      gid  = 5001
    }
  ]
}

# LDAP 用户配置
variable "ldap_users" {
  description = "LDAP 用户配置"
  type = list(object({
    uid           = string
    surname       = string
    given_name    = string
    cn            = string
    display_name  = string
    uid_number    = number
    gid_number    = number
    password_hash = string
    login_shell   = string
    home_dir      = string
  }))
  default = [
    {
      uid           = "testuser"
      surname       = "User"
      given_name    = "Test"
      cn            = "Test User"
      display_name  = "Test User"
      uid_number    = 10000
      gid_number    = 5000
      password_hash = "{SSHA}Eby5DqNessnnA9J/TAH9mMOSXytlMD0Z"
      login_shell   = "/bin/bash"
      home_dir      = "/home/testuser"
    },
    {
      uid           = "adminuser"
      surname       = "Admin"
      given_name    = "User"
      cn            = "Admin User"
      display_name  = "Admin User"
      uid_number    = 10001
      gid_number    = 5001
      password_hash = "{SSHA}Eby5DqNessnnA9J/TAH9mMOSXytlMD0Z"
      login_shell   = "/bin/bash"
      home_dir      = "/home/adminuser"
    }
  ]
}
