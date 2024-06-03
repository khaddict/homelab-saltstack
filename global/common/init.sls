{% import_yaml 'data/network_configs.yaml' as network_configs %}
{% set fqdn = grains["fqdn"] %}

include:
  - .packages
  - .salt-minion
  - .ssh

# /root/.bashrc

bashrc-file:
  file.managed:
    - name: /root/.bashrc
    - source: salt://global/common/files/.bashrc
    - mode: 644
    - user: root
    - group: root

# /etc/network/interfaces

{{ fqdn }}-network-config:
  file.managed:
    - name: /etc/network/interfaces
    - source: salt://global/common/files/network-config
    - template: jinja
    - context:
        main_iface: {{ network_configs.network_config[fqdn].main_iface }}
        ip_addr: {{ network_configs.network_config[fqdn].ip_addr }}
        netmask: {{ network_configs.network_config[fqdn].netmask }}
        gateway: {{ network_configs.network_config[fqdn].gateway }}
        dns_nameservers: {{ ' '.join(network_configs.network_config[fqdn].dns_nameservers) }}
