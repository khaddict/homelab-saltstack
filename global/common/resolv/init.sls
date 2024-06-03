{% import_yaml 'data/network_confs.yaml' as network_confs %}
{% set fqdn = grains["fqdn"] %}

# /etc/resolv.conf

{{ fqdn }}-resolv-conf:
  file.managed:
    - name: /etc/resolv.conf
    - source: salt://global/common/files/resolv-conf
    - template: jinja
    - context:
        dns_nameservers: {{ network_confs.dns_nameservers }}