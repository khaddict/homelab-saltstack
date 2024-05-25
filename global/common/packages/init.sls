{% set pkgs = ["curl", "git", "htop", "tmux", "jq", "rsync"] %}

common_packages:
  pkg.installed:
    - pkgs: {{ pkgs }}
