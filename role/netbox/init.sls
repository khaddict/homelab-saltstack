include:
  - base.postgresql
  - base.redis

netbox_db-script:
  file.managed:
    - name: /tmp/netbox_db.sh
    - source: salt://scripts/netbox_db.sh
    - mode: 755
    - user: root
    - group: root

netbox_dependencies:
  pkg.installed:
    - pkgs:
      - python3
      - python3-pip
      - python3-venv
      - python3-dev
      - build-essential
      - libxml2-dev
      - libxslt1-dev
      - libffi-dev
      - libpq-dev
      - libssl-dev
      - zlib1g-dev
      - git

opt_netbox_dir:
  file.directory:
    - name: /opt/netbox
    - mode: 755

netbox_repo:
  git.latest:
    - name: https://github.com/netbox-community/netbox.git
    - target: /opt/netbox
    - branch: master
    - rev: master
    - depth: 1
    - require:
      - file: opt_netbox_dir

netbox_user:
  user.present:
    - name: netbox
    - usergroup: True

/opt/netbox/netbox/media:
  file.directory:
    - user: netbox
    - group: netbox

/opt/netbox/netbox/reports:
  file.directory:
    - user: netbox
    - group: netbox

/opt/netbox/netbox/scripts:
  file.directory:
    - user: netbox
    - group: netbox

# Need to add Vault to manage passwords.
#configuration_file:
#  file.managed:
#    - name: /opt/netbox/netbox/netbox/configuration.py
#    - source: salt://role/netbox/files/configuration.py
#    - mode: 644
#    - user: root
#    - group: root

gunicorn_file:
  file.managed:
    - name: /opt/netbox/gunicorn.py
    - source: salt://role/netbox/files/gunicorn.py
    - mode: 644
    - user: root
    - group: root