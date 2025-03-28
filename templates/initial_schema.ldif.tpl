# 基本组织结构
dn: ou=People,${ldap_base_dn}
objectClass: organizationalUnit
ou: People

dn: ou=Groups,${ldap_base_dn}
objectClass: organizationalUnit
ou: Groups

# 组定义
%{ for group in ldap_groups ~}
dn: cn=${group.name},ou=Groups,${ldap_base_dn}
objectClass: posixGroup
cn: ${group.name}
gidNumber: ${group.gid}

%{ endfor ~}

# 用户定义
%{ for user in ldap_users ~}
dn: uid=${user.uid},ou=People,${ldap_base_dn}
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: ${user.uid}
sn: ${user.surname}
givenName: ${user.given_name}
cn: ${user.cn}
displayName: ${user.display_name}
uidNumber: ${user.uid_number}
gidNumber: ${user.gid_number}
userPassword: ${user.password_hash}
loginShell: ${user.login_shell}
homeDirectory: ${user.home_dir}

%{ endfor ~}
