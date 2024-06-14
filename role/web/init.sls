{% set host = grains["host"] %}

include:
  - base.nginx

remove_default_nginx_config:
  file.absent:
    - names:
      - /etc/nginx/sites-available/default
      - /etc/nginx/sites-enabled/default
    - require:
      - install_nginx

{{ host }}_config:
  file.managed:
    - name: /etc/nginx/sites-available/{{ host }}.conf
    - source: salt://role/web/files/nginx.conf
    - mode: 644
    - user: root
    - group: root
    - require:
      - file: remove_default_nginx_config
    - template: jinja
    - context:
        host: {{ host }}

add_{{ host }}_symlink:
  file.symlink:
    - name: /etc/nginx/sites-enabled/{{ host }}.conf
    - target: /etc/nginx/sites-available/{{ host }}.conf
    - require:
      - file: {{ host }}_config

{{ host }}_website:
  file.managed:
    - name: /var/www/html/{{ host }}/{{ host }}.html
    - source: salt://role/web/files/website.html
    - mode: 644
    - user: root
    - group: root
    - require:
      - file: remove_default_nginx_config

nginx_service:
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - watch:
      - file: {{ host }}_config
      - file: {{ host }}_website
