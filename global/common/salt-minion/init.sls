{% set osarch = grains["osarch"] %}
{% set osrelease = grains["osrelease"] %}
{% set oscodename = grains["oscodename"] %}
{% set os = grains["os"] | lower %}

minion-config:
  file.managed:
    - name: /etc/salt/minion
    - source: salt://global/common/salt-minion/files/minion
    - mode: 644
    - user: root
    - group: root

salt_repo_pkg:
  pkgrepo.managed:
    - name: deb [arch={{ osarch }} signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg] https://repo.saltproject.io/salt/py3/{{ os }}/{{ osrelease }}/{{ osarch }}/latest {{ oscodename }} main
    - dist: {{ oscodename }}
    - file: /etc/apt/sources.list.d/salt.list
    - key_url: https://repo.saltproject.io/salt/py3/{{ os }}/{{ osrelease }}/{{ osarch }}/SALT-PROJECT-GPG-PUBKEY-2023.gpg

install_salt-minion:
  pkg.installed:
    - name: salt-minion

service_salt-minion:
  service.running:
    - name: salt-minion
    - enable: True
