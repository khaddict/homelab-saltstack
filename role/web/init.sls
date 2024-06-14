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

add_khaddict_symlink:
  file.symlink:
    - name: /etc/nginx/sites-enabled/khaddict.conf
    - target: /etc/nginx/sites-available/khaddict.conf
    - require:
      - file: add_khaddict_config

{{ fqdn }}_website:
  file.managed:
    - name: /var/www/html/{{ fqdn }}.html
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
      - file: add_khaddict_config
      - file: add_khaddict_site
    - reload: true
