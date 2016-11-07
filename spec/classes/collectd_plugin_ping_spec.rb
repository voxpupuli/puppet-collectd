require 'spec_helper'

describe 'collectd::plugin::ping', type: :class do
  let :pre_condition do
    'include ::collectd'
  end

  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':hosts => [\'google.com\']' do
    let :params do
      { hosts: ['google.com'] }
    end
    it 'Will create /etc/collectd.d/10-ping.conf' do
      is_expected.to contain_file('ping.load').with(ensure: 'present',
                                                    path: '/etc/collectd.d/10-ping.conf',
                                                    content: %r{Host "google.com"})
    end
  end

  context ':hosts => [\'google.com\', \'puppetlabs.com\']' do
    let :params do
      { hosts: ['google.com', 'puppetlabs.com'] }
    end
    it 'Will create /etc/collectd.d/10-ping.conf' do
      is_expected.to contain_file('ping.load').with(ensure: 'present',
                                                    path: '/etc/collectd.d/10-ping.conf').with_content(
                                                      %r{Host "google.com"}
                                                    ).with_content(
                                                      %r{Host "puppetlabs.com"}
                                                    )
    end
  end

  context ':ensure => absent' do
    let :params do
      { hosts: ['google.com'], ensure: 'absent' }
    end
    it 'Will not create /etc/collectd.d/10-ping.conf' do
      is_expected.to contain_file('ping.load').with(ensure: 'absent',
                                                    path: '/etc/collectd.d/10-ping.conf')
    end
  end

  context ':hosts is not an array' do
    let :params do
      { hosts: 'google.com' }
    end
    it 'Will raise an error about :interfaces being a String' do
      is_expected.to compile.and_raise_error(%r{String})
    end
  end
end
