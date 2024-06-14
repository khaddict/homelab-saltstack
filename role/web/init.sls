include:
  - base.nginx

remove_default_nginx_config:
  file.absent:
    - names:
      - /etc/nginx/sites-available/default
      - /etc/nginx/sites-enabled/default
    - require:
      - install_nginx

add_khaddict_config:
  file.managed:
    - name: /etc/nginx/sites-available/khaddict.conf
    - source: salt://role/web/files/khaddict.conf
    - mode: 644
    - user: root
    - group: root
    - require:
      - file: remove_default_nginx_config

add_khaddict_symlink:
  file.symlink:
    - name: /etc/nginx/sites-enabled/khaddict.conf
    - target: /etc/nginx/sites-available/khaddict.conf
    - require:
      - file: add_khaddict_config

add_khaddict_site:
  file.managed:
    - name: /var/www/html/khaddict.html
    - source: salt://role/web/files/khaddict.html
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
