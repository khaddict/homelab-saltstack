include:
  - .packages
  - .salt-minion
  - .ssh

# .bashrc file

bashrc-file:
  file.managed:
    - name: /root/.bashrc
    - source: salt://global/common/files/.bashrc
    - mode: 644
    - user: root
    - group: root

authorized_keys-file:
  file.managed:
    - name: /root/.ssh/authorized_keys
    - source: salt://global/common/files/authorized_keys
    - mode: 644
    - user: root
    - group: root
