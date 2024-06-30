{% set elastic_password = salt['vault'].read_secret('kv/elk').elastic_password %}

install_logstash:
  pkg.installed:
    - name: logstash

logstash_conf_directory:
  file.recurse:
    - name: /etc/logstash/conf.d
    - source: salt://role/elk/files/logstash_conf
    - include_empty: True
    - template: jinja
    - context:
        elastic_password: {{ elastic_password }}

service_logstash:
  service.running:
    - name: logstash
    - enable: True
    - require:
      - pkg: install_logstash
    - watch:
      - file: logstash_conf_directory
