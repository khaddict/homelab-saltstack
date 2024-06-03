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
