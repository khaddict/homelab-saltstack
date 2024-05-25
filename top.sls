# All hosts configuration
base:
  '*':
    - global

# Per role configuration
  'saltmaster.homelab.lan':
    - role.saltmaster

  'master.homelab.lan':
    - role.master

  'pi-hole.homelab.lan':
    - role.pi-hole
