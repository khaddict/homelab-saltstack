{% set oscodename = grains["oscodename"] %}

# /etc/apt/sources.list

sources_config:
  file.managed:
    - name: /etc/apt/sources.list
    - source: salt://global/common/sources/files/sources.list
    - template: jinja
    - context:
        oscodename: {{ oscodename }}
