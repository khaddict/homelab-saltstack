{% import_yaml 'data/network_confs.yaml' as network_confs %}
{% set fqdn = grains["fqdn"] %}

# /etc/network/interfaces

{{ fqdn }}-network-conf:
  file.managed:
    - name: /etc/network/interfaces
    {% if fqdn is match('n\d-cls\d\.homelab\.lan') %}
    - source: salt://global/common/files/network-conf-proxmox
    {% else %}
    - source: salt://global/common/files/network-conf
    {% endif %}
    - template: jinja
    - context:
        main_iface: {{ network_confs.network_conf[fqdn].main_iface }}
        ip_addr: {{ network_confs.network_conf[fqdn].ip_addr }}
        netmask: {{ network_confs.network_conf[fqdn].netmask }}
        gateway: {{ network_confs.network_conf[fqdn].gateway }}