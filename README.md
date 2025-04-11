<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_zstack"></a> [zstack](#requirement\_zstack) | 1.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_openldap_image"></a> [openldap\_image](#module\_openldap\_image) | git::http://172.20.14.17/jiajian.chi/terraform-zstack-image.git | n/a |
| <a name="module_openldap_instance"></a> [openldap\_instance](#module\_openldap\_instance) | git::http://172.20.14.17/jiajian.chi/terraform-zstack-instance.git | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.docker_compose](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.initial_schema](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [terraform_data.remote_exec](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_storage_name"></a> [backup\_storage\_name](#input\_backup\_storage\_name) | Name of the backup storage to use | `string` | `"Ceph"` | no |
| <a name="input_context"></a> [context](#input\_context) | Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.<br/><br/>Examples:<pre>context:<br/>  project:<br/>    name: string<br/>    id: string<br/>  environment:<br/>    name: string<br/>    id: string<br/>  resource:<br/>    name: string<br/>    id: string</pre> | `map(any)` | `{}` | no |
| <a name="input_expunge"></a> [expunge](#input\_expunge) | n/a | `bool` | `true` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Name for the log server image | `string` | `"openldap-by-terraform"` | no |
| <a name="input_image_url"></a> [image\_url](#input\_image\_url) | URL to download the image from | `string` | `"http://minio.zstack.io:9001/packer/openldap-by-packer-image-compressed.qcow2"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name for the openldap server instance | `string` | `"openldap"` | no |
| <a name="input_instance_offering_name"></a> [instance\_offering\_name](#input\_instance\_offering\_name) | Name of the instance offering to use | `string` | `"min"` | no |
| <a name="input_l3_network_name"></a> [l3\_network\_name](#input\_l3\_network\_name) | Name of the L3 network to use | `string` | `"test"` | no |
| <a name="input_ldap_admin_password"></a> [ldap\_admin\_password](#input\_ldap\_admin\_password) | LDAP 管理员密码 | `string` | `"admin"` | no |
| <a name="input_ldap_base_dn"></a> [ldap\_base\_dn](#input\_ldap\_base\_dn) | LDAP Base DN | `string` | `"dc=example,dc=org"` | no |
| <a name="input_ldap_config_password"></a> [ldap\_config\_password](#input\_ldap\_config\_password) | LDAP 配置密码 | `string` | `"config"` | no |
| <a name="input_ldap_domain"></a> [ldap\_domain](#input\_ldap\_domain) | LDAP 域名 | `string` | `"example.org"` | no |
| <a name="input_ldap_groups"></a> [ldap\_groups](#input\_ldap\_groups) | LDAP 组配置 | <pre>list(object({<br/>    name     = string<br/>    gid      = number<br/>  }))</pre> | <pre>[<br/>  {<br/>    "gid": 5000,<br/>    "name": "users"<br/>  },<br/>  {<br/>    "gid": 5001,<br/>    "name": "admins"<br/>  }<br/>]</pre> | no |
| <a name="input_ldap_organisation"></a> [ldap\_organisation](#input\_ldap\_organisation) | LDAP 组织名称 | `string` | `"Example Inc"` | no |
| <a name="input_ldap_readonly_password"></a> [ldap\_readonly\_password](#input\_ldap\_readonly\_password) | LDAP 只读用户密码 | `string` | `"readonly"` | no |
| <a name="input_ldap_readonly_user"></a> [ldap\_readonly\_user](#input\_ldap\_readonly\_user) | 是否创建只读用户 | `bool` | `true` | no |
| <a name="input_ldap_readonly_username"></a> [ldap\_readonly\_username](#input\_ldap\_readonly\_username) | LDAP 只读用户名 | `string` | `"readonly"` | no |
| <a name="input_ldap_users"></a> [ldap\_users](#input\_ldap\_users) | LDAP 用户配置 | <pre>list(object({<br/>    uid           = string<br/>    surname       = string<br/>    given_name    = string<br/>    cn            = string<br/>    display_name  = string<br/>    uid_number    = number<br/>    gid_number    = number<br/>    password_hash = string<br/>    login_shell   = string<br/>    home_dir      = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "cn": "Test User",<br/>    "display_name": "Test User",<br/>    "gid_number": 5000,<br/>    "given_name": "Test",<br/>    "home_dir": "/home/testuser",<br/>    "login_shell": "/bin/bash",<br/>    "password_hash": "{SSHA}Eby5DqNessnnA9J/TAH9mMOSXytlMD0Z",<br/>    "surname": "User",<br/>    "uid": "testuser",<br/>    "uid_number": 10000<br/>  },<br/>  {<br/>    "cn": "Admin User",<br/>    "display_name": "Admin User",<br/>    "gid_number": 5001,<br/>    "given_name": "User",<br/>    "home_dir": "/home/adminuser",<br/>    "login_shell": "/bin/bash",<br/>    "password_hash": "{SSHA}Eby5DqNessnnA9J/TAH9mMOSXytlMD0Z",<br/>    "surname": "Admin",<br/>    "uid": "adminuser",<br/>    "uid_number": 10001<br/>  }<br/>]</pre> | no |
| <a name="input_ssh_password"></a> [ssh\_password](#input\_ssh\_password) | SSH password for remote access | `string` | `"password"` | no |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | SSH username for remote access | `string` | `"root"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoints"></a> [endpoints](#output\_endpoints) | n/a |
| <a name="output_ldap_connection_string"></a> [ldap\_connection\_string](#output\_ldap\_connection\_string) | LDAP 连接字符串 |
| <a name="output_ldaps_connection_string"></a> [ldaps\_connection\_string](#output\_ldaps\_connection\_string) | LDAPS 连接字符串 |
| <a name="output_openldap_admin_dn"></a> [openldap\_admin\_dn](#output\_openldap\_admin\_dn) | OpenLDAP 管理员 DN |
| <a name="output_openldap_admin_password"></a> [openldap\_admin\_password](#output\_openldap\_admin\_password) | OpenLDAP 管理员密码 |
| <a name="output_openldap_server_ip"></a> [openldap\_server\_ip](#output\_openldap\_server\_ip) | OpenLDAP 服务器 IP 地址 |
| <a name="output_phpldapadmin_url"></a> [phpldapadmin\_url](#output\_phpldapadmin\_url) | phpLDAPadmin 访问 URL |
| <a name="output_walrus_environment_id"></a> [walrus\_environment\_id](#output\_walrus\_environment\_id) | The id of environment where deployed in Walrus. |
| <a name="output_walrus_environment_name"></a> [walrus\_environment\_name](#output\_walrus\_environment\_name) | The name of environment where deployed in Walrus. |
| <a name="output_walrus_project_id"></a> [walrus\_project\_id](#output\_walrus\_project\_id) | The id of project where deployed in Walrus. |
| <a name="output_walrus_project_name"></a> [walrus\_project\_name](#output\_walrus\_project\_name) | The name of project where deployed in Walrus. |
| <a name="output_walrus_resource_id"></a> [walrus\_resource\_id](#output\_walrus\_resource\_id) | The id of resource where deployed in Walrus. |
| <a name="output_walrus_resource_name"></a> [walrus\_resource\_name](#output\_walrus\_resource\_name) | The name of resource where deployed in Walrus. |
<!-- END_TF_DOCS -->


## phpLDAPadmin 登录

部署完成后，您可以通过浏览器访问 phpLDAPadmin 界面来管理 LDAP 目录。

### 管理员登录

1. 在浏览器中打开 phpLDAPadmin URL (http://server-ip:8080)
2. 在登录界面点击"登录"按钮
3. 使用以下管理员凭据:
   - **登录DN**: `cn=admin,dc=yourdomain,dc=com`  
     (根据您配置的 ldap_base_dn 变量，例如默认值为 `cn=admin,dc=example,dc=org`)
   - **密码**: `admin` (或您在 `ldap_admin_password` 变量中设置的密码)

### 只读用户登录

如果您启用了只读用户 (`ldap_readonly_user = true`):

1. 在浏览器中打开 phpLDAPadmin URL
2. 在登录界面点击"登录"按钮
3. 使用以下只读用户凭据:
   - **登录DN**: `cn=readonly,dc=yourdomain,dc=com`  
     (根据您配置的 ldap_base_dn 变量)
   - **密码**: `readonly123` (或您在 `ldap_readonly_password` 变量中设置的密码)

### 普通用户登录

您也可以使用已创建的普通用户账户登录:

1. 在浏览器中打开 phpLDAPadmin URL
2. 在登录界面点击"登录"按钮
3. 使用以下用户凭据:
   - **登录DN**: `uid=testuser,ou=People,dc=yourdomain,dc=com`  
     (根据您配置的用户和 ldap_base_dn 变量)
   - **密码**: `password123` (对应于示例中的哈希值)

同样，管理员用户也可以使用:
   - **登录DN**: `uid=adminuser,ou=People,dc=yourdomain,dc=com`
   - **密码**: `password123`

## 密码哈希生成

要生成新的 LDAP 密码哈希，可以使用以下命令：

```bash
slappasswd -h {SSHA} -s your_password
```

例如，生成示例中使用的密码哈希：

```bash
slappasswd -h {SSHA} -s password123
```


## 输出值

| 输出名 | 描述 |
|--------|------|
| openldap_server_ip | OpenLDAP 服务器 IP 地址 |
| openldap_admin_dn | OpenLDAP 管理员 DN |
| openldap_admin_password | OpenLDAP 管理员密码 |
| phpldapadmin_url | phpLDAPadmin 访问 URL |
| ldap_connection_string | LDAP 连接字符串 |
| ldaps_connection_string | LDAPS 连接字符串 |



要生成新的 LDAP 密码哈希，可以使用以下命令：

```bash
slappasswd -h {SSHA} -s your_password
```
