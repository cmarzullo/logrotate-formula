# logrotate-formula
salt formula to configure logrotate and extra config files.

## Default config
The default state will only ensure that the main logrotate file is the same is it is out of the box (package).
```
logrotate:
  enabled: true
```
test/integration/default/_spec.rb is configured to test that the md5 sum of the stock Debian config file matches that which is created by salt.

## Changing the stock configuration
To change any options in the main config file, add them like so:
```
logrotate:
  enabled: true
  config:
    - weekly
    - rotate 4
    - create
    - compress
    - include /etc/logrotate.d
```

## Extra config files
To create one or more new files under /etc/logstash.d, do something like this:
```
logrotate:
  enabled: true
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
```
this will create /etc/logstash.d/anewapp and /etc/logstash.d/anotherapp and format the internals as they should be for maximum effectiveness.

## How to dev
Install and setup brew:
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

```
brew install cask
brew cask install vagrant
```

```
cd <formula dir>
bundle install
```
or
```
sudo gem install test-kitchen
sudo gem install kitchen-vagrant
sudo gem install kitchen-salt
```

Run a converge on the default configuration:
```
kitchen converge default
```
