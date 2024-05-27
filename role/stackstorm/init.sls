st2_homelab-folder:
  file.recurse:
    - name: /opt/stackstorm/packs/st2_homelab
    - source: salt://role/stackstorm/files/st2_homelab
    - include_empty: True

st2_homelab-installation:
  cmd.run:
    - name: "st2 pack install file:///opt/stackstorm/packs/st2_homelab/"
    - require: 
        - st2_homelab-folder
