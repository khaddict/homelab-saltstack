minion-config:
  file.managed:
    - name: /etc/salt/minion
    - source: salt://global/common/salt-minion/minion

gpg-pubkey:
  file.managed:
    - name: /etc/apt/keyrings/salt-archive-keyring-2023.gpg
    - source: salt://global/common/salt-minion/SALT-PROJECT-GPG-PUBKEY-2023.gpg

salt_repo_pkg:
  pkgrepo.managed:
    - name: deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=amd64] https://repo.saltproject.io/salt/py3/debian/12/amd64/latest bookworm main
    - dist: bookworm
    - file: /etc/apt/sources.list.d/salt.list

install_salt-minion:
  pkg.installed:
    - pkgs: salt-minion

service_salt-minion:
  service.running:
    - name: salt-minion
    - enable: True