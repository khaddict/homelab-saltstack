{% set oscodename = grains["oscodename"] %}

grafana_dependencies:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - software-properties-common
      - wget

manage_grafana_key:
  file.managed:
    - name: /usr/share/keyrings/grafana.key
    - source: salt://role/grafana/files/grafana.key
    - mode: 644
    - user: root
    - group: root

grafana_repo_pkg:
  pkgrepo.managed:
    - name: deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main
    - file: /etc/apt/sources.list.d/grafana.list
    - require:
      - file: manage_grafana_key

install_grafana:
  pkg.installed:
    - name: grafana

service_grafana:
  service.running:
    - name: grafana
    - enable: True
    - require:
      - pkg: install_grafana
