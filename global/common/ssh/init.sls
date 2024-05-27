ssh_pkg:
  pkg.installed:
    - name: openssh-server

sshd_config:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source: salt://global/common/ssh/files/sshd_config
    - mode: 644
    - user: root
    - group: root

authorized_keys-file:
  file.managed:
    - name: /root/.ssh/authorized_keys
    - source: salt://global/common/ssh/files/authorized_keys
    - mode: 600
    - user: root
    - group: root

service_ssh:
  service.running:
    - name: ssh
    - enable: True
    - reload: True
