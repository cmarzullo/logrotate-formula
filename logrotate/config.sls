# vim: ft=sls
# How to configure logrotate
{% from "logrotate/map.jinja" import logrotate with context %}

logrotate_config:
  file.managed:
    - name: /etc/logrotate.conf
    - source: salt://logrotate/files/logrotate.conf.j2
    - user: root
    - group : root
    - mode: 0644
    - template: jinja
    {% if logrotate.config is defined -%}
    - conf: {{ logrotate.config }}
    {% endif %}

logrotate_config_dir:
  file.directory:
    - name: /etc/logrotate.d
    - user: root
    - group: root
    - mode: 0755

{% if logrotate.extra is defined %}
{%   for key,vals in logrotate.extra.iteritems() %}
logrotate_extra_config_{{ key }}:
  file.managed:
    - name: /etc/logrotate.d/{{ key }}
    - source: salt://logrotate/files/extra_conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - conf: {{ vals }}
{%   endfor %}
{% endif %}
