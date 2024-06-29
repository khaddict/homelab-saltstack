{% set ca_password = salt['vault'].read_secret('kv/ca').ca_password %}

st2_homelab_folder:
  file.recurse:
    - name: /opt/stackstorm/packs/st2_homelab
    - source: salt://role/stackstorm/files/st2_homelab
    - include_empty: True

st2_homelab_configs:
  file.managed:
    - name: /opt/stackstorm/configs/st2_homelab.yaml
    - source: salt://role/stackstorm/files/st2_homelab.yaml
    - mode: 640
    - user: root
    - group: root
    - template: jinja
    - context:
        ca_password: {{ ca_password }}

st2_homelab_installation:
  cmd.run:
    - name: "st2 pack install file:///opt/stackstorm/packs/st2_homelab/"
    - require: 
        - file: st2_homelab_folder
