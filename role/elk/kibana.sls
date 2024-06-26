install_kibana:
  pkg.installed:
    - name: kibana

kibana_config:
  file.managed:
    - name: /etc/kibana/kibana.yml
    - source: salt://role/elk/files/kibana.yml
    - mode: 660
    - user: root
    - group: kibana

service_kibana:
  service.running:
    - name: kibana
    - enable: True
    - require:
      - pkg: install_kibana
    - watch:
      - file: kibana_config
