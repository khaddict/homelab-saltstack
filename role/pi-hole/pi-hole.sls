pi_hole_dns_entries_config:
  file.managed:
    - name: /etc/pihole/custom.list
    - source: salt://role/pi-hole/files/custom.list
    - mode: 644
    - user: root
    - group: root

reload_pihole_service:
  service.running:
    - name: pihole-FTL
    - enable: True
    - reload: True
    - watch:
      - file: pi_hole_dns_entries_config
