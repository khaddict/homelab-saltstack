{% set salt_policy_token = salt['vault'].read_secret('kv/vault_tokens').salt_policy_token %}

vault_config:
  file.managed:
    - name: /etc/salt/master.d/vault.conf
    - source: salt://role/saltmaster/files/vault.conf
    - mode: 644
    - user: root
    - group: root
    - context:
        salt_policy_token: {{ salt_policy_token }}