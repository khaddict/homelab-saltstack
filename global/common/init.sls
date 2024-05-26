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
