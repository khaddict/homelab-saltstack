# /root/.bashrc

bashrc_file:
  file.managed:
    - name: /root/.bashrc
    - source: salt://global/common/bashrc/files/.bashrc
    - mode: 644
    - user: root
    - group: root