{% set fqdn = grains["fqdn"] %}

include:
  - base.nginx

remove_default_nginx_config:
  file.absent:
    - names:
      - /etc/nginx/sites-available/default
      - /etc/nginx/sites-enabled/default
    - require:
      - install_nginx

{{ fqdn }}_config:
  file.managed:
    - name: /etc/nginx/sites-available/{{ fqdn }}.conf
    - source: salt://role/web/files/nginx.conf
    - mode: 644
    - user: root
    - group: root
    - require:
      - file: remove_default_nginx_config
    - template: jinja
    - context:
        fqdn: {{ fqdn }}

add_{{ fqdn }}_symlink:
  file.symlink:
    - name: /etc/nginx/sites-enabled/{{ fqdn }}.conf
    - target: /etc/nginx/sites-available/{{ fqdn }}.conf
    - require:
      - file: {{ fqdn }}_config

{{ fqdn }}_website:
  file.managed:
    - name: /var/www/html/{{ fqdn }}/{{ fqdn }}.html
    - source: salt://role/web/files/website.html
    - mode: 644
    - user: root
    - group: root
    - require:
      - file: remove_default_nginx_config

nginx_service:
  service.running:
    - name: nginx
    - enable: true
    - watch:
      - file: {{ fqdn }}_config
      - file: {{ fqdn }}_website
    - reload: true
