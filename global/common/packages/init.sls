{% set pkgs = ["curl", "git"] %}

common_packages:
  pkg.installed:
    - pkgs: {{ pkgs }}
