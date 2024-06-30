{% import_yaml 'data/network_confs.yaml' as network_confs %}
{% set fqdn = grains["fqdn"] %}

include:
  - .packages
  - .salt-minion
  - .ssh
  - .bashrc
  - .hosts
  - .resolv
  - .network
  - .ca
  - .ntp
  - .log
  - base.node_exporter
