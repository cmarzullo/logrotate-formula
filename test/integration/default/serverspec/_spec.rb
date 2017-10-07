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
    its(:md5sum) { should eq '176edd439a499501372cf3d04e795810' }
end
