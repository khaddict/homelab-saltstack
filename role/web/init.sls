include:
  - base.nginx

remove_default_nginx_config:
  file.absent:
    - name: /etc/nginx/sites-available/default
    - require:
      - install_nginx

add_khaddict_config:
  file.managed:
    - name: /etc/nginx/sites-available/khaddict
    - source: salt://role/web/files/khaddict
    - mode: 644
    - user: root
    - group: root
    - require:
      - file: remove_default_nginx_config