require 'serverspec'

# Required by serverspec
set :backend, :exec


describe package('logrotate') do
  it { should be_installed }
end

describe file('/etc/logrotate.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should match /^## managed by salt/ }
  its(:content) { should match /^weekly/ }
  its(:content) { should match /^rotate 4/ }
  its(:content) { should match /^create/ }
  its(:content) { should match /^compress/ }
  its(:content) { should match /^include \/etc\/logrotate.d/ }
  its(:content) { should match /^## end managed by salt/ }
end

anewapp = "/var/log/anewapp/main.log {
  rotate 12
  monthly
  compress
  missingok
  notifempty
  
}
/var/log/anewapp/second.log {
  rotate 12
  monthly
  compress
  missingok
  notifempty
  
}

"

describe file('/etc/logrotate.d/anewapp') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should eq anewapp }
end

anotherapp = "/var/log/anotherapp {
  rotate 6
  monthly
  compress
  missingok
  notifempty
  
}

"

describe file('/etc/logrotate.d/anotherapp') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its(:content) { should eq anotherapp }
end
