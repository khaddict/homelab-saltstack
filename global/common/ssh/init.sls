ssh_pkg:
  pkg.installed:
    - name: openssh-server

sshd_config:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source: salt://base/openssh/files/sshd_config
    - mode: 644
    - user: root
    - group: root