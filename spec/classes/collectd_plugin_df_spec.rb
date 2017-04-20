require 'spec_helper'

describe 'collectd::plugin::df', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context 'simple case' do
    let :params do
      {
      }
    end

    it 'Will create /etc/collectd.d/10-df.conf' do
      is_expected.to contain_file('df.load').with(ensure: 'present',
                                                  path: '/etc/collectd.d/10-df.conf',
                                                  content: %r{LoadPlugin df})
    end
  end

  context 'devices case' do
    let :params do
      {
        devices: %w[proc sysfs]
      }
    end

    it 'Will create /etc/collectd.d/10-df.conf' do
      is_expected.to contain_file('df.load').with(ensure: 'present',
                                                  path: '/etc/collectd.d/10-df.conf',
                                                  content: %r{  Device \"proc\"\n  Device \"sysfs\"\n})
    end
  end

  context 'ensure => absent' do
    let :params do
      {
        ensure: 'absent'
      }
    end

    it 'Will create /etc/collectd.d/10-df.conf' do
      is_expected.to contain_file('df.load').with(ensure: 'absent',
                                                  path: '/etc/collectd.d/10-df.conf')
    end
  end
end
