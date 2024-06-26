elk_dependencies:
  pkg.installed:
    - pkgs:
      - apt-transport-https

manage_elk_gpg:
  file.managed:
    - name: /usr/share/keyrings/elasticsearch-keyring.gpg
    - source: salt://role/elk/files/elasticsearch-keyring.gpg
    - mode: 644
    - user: root
    - group: root

elk_repo_pkg:
  pkgrepo.managed:
    - name: deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main
    - file: /etc/apt/sources.list.d/elastic-8.x.list
    - require:
      - file: manage_elk_gpg

install_elk:
  pkg.installed:
    - name: elasticsearch
