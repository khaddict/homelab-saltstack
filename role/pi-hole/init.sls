pi-hole-dns-entries-config:
  file.managed:
    - name: /etc/pihole/custom.list
    - source: salt://role/pi-hole/files/custom.list
    - mode: 644
    - user: root
    - group: root
