include:
  - base.postgresql

netbox_db-script:
  file.managed:
    - name: /tmp/netbox_db.sh
    - source: salt://scripts/netbox_db.sh
    - mode: 755
    - user: root
    - group: root