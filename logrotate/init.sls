# vim: ft=sls
# Init logrotate
{%- from "logrotate/map.jinja" import logrotate with context %}
{# Below is an example of having a toggle for the state #}

{% if logrotate.enabled %}
include:
  - logrotate.install
  - logrotate.config
{% else %}
'logrotate-formula disabled':
  test.succeed_without_changes
{% endif %}
