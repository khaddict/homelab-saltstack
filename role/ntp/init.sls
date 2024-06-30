chrony_server_config:
  file.managed:
    - name: /etc/chrony/chrony.conf
    - source: salt://global/role/ntp/files/chrony.conf
    - mode: 644
    - user: root
    - group: root

enable_service_chrony:
  service.running:
    - name: chrony
    - enable: True
    - reload: True
    - watch:
      - file: chrony_server_config
