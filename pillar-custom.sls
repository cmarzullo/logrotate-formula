# vim: ft=yaml
# Custom Pillar Data for logrotate

logrotate:
  enabled: true
  config:
    - weekly
    - rotate 4
    - create
    - compress
    - include /etc/logrotate.d
  extra:
    anewapp:
      /var/log/anewapp/main.log:
        - rotate 12
        - monthly
        - compress
        - missingok
        - notifempty
      /var/log/anewapp/second.log:
        - rotate 12
        - monthly
        - compress
        - missingok
        - notifempty
    anotherapp:
      /var/log/anotherapp:
        - rotate 6
        - monthly
        - compress
        - missingok
        - notifempty
