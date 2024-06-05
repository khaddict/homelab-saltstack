pi-hole-dns-entries-config:
  file.managed:
    - name: /etc/pihole/custom.list
    - source: salt://role/pi-hole/files/custom.list
    - mode: 644
    - user: root
    - group: root

reload-pihole-service:
  service.running:
    - name: pihole-FTL
    - enable: True
    - reload: True
    - watch:
      - file: pi-hole-dns-entries-config