minion-config:
  file.managed:
    - name: /etc/salt/minion
    - source: salt://global/common/salt-minion/files/minion
    - mode: 644
    - user: root
    - group: root

gpg-pubkey:
  file.managed:
    - name: /etc/apt/keyrings/salt-archive-keyring-2023.gpg
    - source: salt://global/common/salt-minion/files/SALT-PROJECT-GPG-PUBKEY-2023.gpg
    - mode: 644
    - user: root
    - group: root

salt_repo_pkg:
  pkgrepo.managed:
    - name: deb [arch=amd64 signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg] https://repo.saltproject.io/salt/py3/debian/12/amd64/latest bookworm main
    - dist: bookworm
    - file: /etc/apt/sources.list.d/salt.list
    - mode: 644
    - user: root
    - group: root

install_salt-minion:
  pkg.installed:
    - name: salt-minion

service_salt-minion:
  service.running:
    - name: salt-minion
    - enable: True
