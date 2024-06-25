{% set oscodename = grains["oscodename"] %}

grafana_dependencies:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - software-properties-common
      - wget

manage_grafana_gpg:
  file.managed:
    - name: /etc/apt/keyrings/grafana.gpg
    - source: salt://role/grafana/files/grafana.gpg
    - mode: 644
    - user: root
    - group: root

grafana_repo_pkg:
  pkgrepo.managed:
    - name: deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main
    - dist: {{ oscodename }}
    - file: /etc/apt/sources.list.d/grafana.list
    - require:
      - file: manage_grafana_gpg

install_grafana:
  pkg.installed:
    - name: grafana
