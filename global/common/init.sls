{% import_yaml 'data/network_confs.yaml' as network_confs %}
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

{{ fqdn }}-network-conf:
  file.managed:
    - name: /etc/network/interfaces
    - source: salt://global/common/files/network-conf
    - template: jinja
    - context:
        main_iface: {{ network_confs.network_conf[fqdn].main_iface }}
        ip_addr: {{ network_confs.network_conf[fqdn].ip_addr }}
        netmask: {{ network_confs.network_conf[fqdn].netmask }}
        gateway: {{ network_confs.network_conf[fqdn].gateway }}

resolv-conf:
  file.managed:
    - name: /etc/resolv.conf
    - source: salt://global/common/files/resolv-conf
    - template: jinja
    - context:
        dns_nameservers: {{ ' '.join(network_confs.dns_nameservers) }}
