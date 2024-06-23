# All hosts configuration
base:
  '*':
    - global

# Per role configuration
  'n?-cls?.homelab.lan':
    - role.proxmox

  'saltmaster.homelab.lan':
    - role.saltmaster

  'main.homelab.lan':
    - role.main

  'pi-hole??.homelab.lan':
    - role.pi-hole

  'stackstorm.homelab.lan':
    - role.stackstorm

  'netbox.homelab.lan':
    - role.netbox

  'vault.homelab.lan':
    - role.vault

  'web??.homelab.lan':
    - role.web

  'ha??.homelab.lan':
    - role.ha

  'ldap.homelab.lan':
    - role.ldap

  'prometheus.homelab.lan':
    - role.prometheus

  'ca.homelab.lan':
    - role.ca

  'ntp.homelab.lan':
    - role.ntp

  'grafana.homelab.lan':
    - role.grafana