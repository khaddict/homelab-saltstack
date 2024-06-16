include:
  - base.haproxy
  - base.keepalived

haproxy_config:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://role/ha/files/haproxy.cfg
    - mode: 644
    - user: root
    - group: root

restart_haproxy_service:
  service.running:
    - name: haproxy
    - enable: True
    - reload: True
    - watch:
      - file: haproxy_config