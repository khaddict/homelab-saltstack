install_logstash:
  pkg.installed:
    - name: logstash

service_logstash:
  service.running:
    - name: logstash
    - enable: True
    - require:
      - pkg: install_logstash
