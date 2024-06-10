{% set osarch = grains["osarch"] %}
{% set oscodename = grains["oscodename"] %}

vault_dependencies:
  pkg.installed:
    - pkgs:
      - gpg
      - wget

download_vault_gpg_key:
  file.managed:
    - name: /usr/share/keyrings/hashicorp-archive-keyring.gpg
    - source: https://apt.releases.hashicorp.com/gpg
    - makedirs: True
    - user: root
    - group: root
    - mode: 644
    - skip_verify: True

salt_repo_pkg:
  pkgrepo.managed:
    - name: deb [arch={{ osarch }} signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com {{ oscodename }} main
    - dist: {{ oscodename }}
    - file: /etc/apt/sources.list.d/hashicorp.list
    - require:
      - file: download_vault_gpg_key

install_vault:
  pkg.installed:
    - name: vault