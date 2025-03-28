version: '3'

services:
  openldap:
    image: osixia/openldap:stable
    container_name: openldap
    environment:
      LDAP_ORGANISATION: "${ldap_organisation}"
      LDAP_DOMAIN: "${ldap_domain}"
      LDAP_BASE_DN: "${ldap_base_dn}"
      LDAP_ADMIN_PASSWORD: "${ldap_admin_password}"
      LDAP_CONFIG_PASSWORD: "${ldap_config_password}"
      LDAP_READONLY_USER: "${ldap_readonly_user}"
      LDAP_READONLY_USER_USERNAME: "${ldap_readonly_username}"
      LDAP_READONLY_USER_PASSWORD: "${ldap_readonly_password}"
    volumes:
      - /opt/openldap/data:/var/lib/ldap
      - /opt/openldap/config:/etc/ldap/slapd.d
      - /opt/openldap/certs:/container/service/slapd/assets/certs
    ports:
      - "389:389"
      - "636:636"
    restart: unless-stopped

  phpldapadmin:
    image: osixia/phpldapadmin:stable
    container_name: phpldapadmin
    environment:
      PHPLDAPADMIN_LDAP_HOSTS: openldap
      PHPLDAPADMIN_HTTPS: "false"
    ports:
      - "8080:80"
    depends_on:
      - openldap
    restart: unless-stopped
