# vim: ft=sls
# How to install logrotate
{%- from "logrotate/map.jinja" import logrotate with context %}

logrotate_pkg:
  pkg.installed:
    - name: {{ logrotate.pkg }}
