{% set pkgs = ["curl", "git", "htop", "tmux", "jq", "rsync", "tree"] %}

common_packages:
  pkg.installed:
    - pkgs: {{ pkgs }}
