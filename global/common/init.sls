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
        ip: {{ network_configs.network_config.fqdn.ip }}
