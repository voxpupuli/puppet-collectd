require 'spec_helper'

describe 'collectd::plugin::tcpconns', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':ensure => present and :localports => [22,25]' do
    let :params do
      { localports: [22, 25] }
    end
    it 'Will create /etc/collectd.d/10-tcpconns.conf' do
      is_expected.to contain_file('tcpconns.load').with(ensure: 'present',
                                                        path: '/etc/collectd.d/10-tcpconns.conf',
                                                        content: %r{LocalPort "22".+LocalPort "25"}m)
    end
  end

  context ':ensure => present, :localports => [22,25] and :remoteports => [3306]' do
    let :params do
      { localports: [22, 25], remoteports: [3306] }
    end
    it 'Will create /etc/collectd.d/10-tcpconns.conf' do
      is_expected.to contain_file('tcpconns.load').with(ensure: 'present',
                                                        path: '/etc/collectd.d/10-tcpconns.conf',
                                                        content: %r{LocalPort "22".+LocalPort "25".+RemotePort "3306"}m)
    end
  end

  context ':ensure => absent' do
    let :params do
      { localports: [22], ensure: 'absent' }
    end
    it 'Will not create /etc/collectd.d/10-tcpconns.conf' do
      is_expected.to contain_file('tcpconns.load').with(ensure: 'absent',
                                                        path: '/etc/collectd.d/10-tcpconns.conf')
    end
  end

  context ':localports is not an array' do
    let :params do
      { localports: '22' }
    end
    it 'Will raise an error about :localports being a String' do
      is_expected.to compile.and_raise_error(%r{String})
    end
  end

  context ':remoteports is not an array' do
    let :params do
      { remoteports: '22' }
    end
    it 'Will raise an error about :remoteports being a String' do
      is_expected.to compile.and_raise_error(%r{String})
    end
  end

  context ':allportssummary is not a boolean' do
    let :params do
      { allportssummary: 'aString' }
    end
    it 'Will raise an error about :allportssummary being a String' do
      expect { is_expected.to.to raise_error(Puppet::Error, %r{String}) }
    end
  end

  context ':allportssummary => true with collectd_version < 5.5.0' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4.1',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      { ensure: 'present', allportssummary: true }
    end

    it 'does not include AllPortsSummary in /etc/collectd.d/10-tcpconns.conf' do
      is_expected.to contain_file('tcpconns.load').without_content(%r{AllPortsSummary})
    end
  end

  context ':allportssummary => true with collectd_version = 5.5.0' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.5.0',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      { ensure: 'present', allportssummary: true }
    end

    it 'includes AllPortsSummary in /etc/collectd.d/10-tcpconns.conf' do
      is_expected.to contain_file('tcpconns.load').with_content(%r{AllPortsSummary true})
    end
  end
end
