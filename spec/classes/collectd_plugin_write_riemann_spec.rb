require 'spec_helper'

describe 'collectd::plugin::write_riemann', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '5.5.0',
    }
  end

  context ':ensure => present and :riemann_host => \'myhost\'' do
    let :params do
      { riemann_host: 'myhost', riemann_port: '5555', protocol: 'TCP', batch: 'false' }
    end
    it 'Will create /etc/collectd.d/10-write_riemann.conf' do
      should contain_file('write_riemann.load').with(ensure: 'present',
                                               path: '/etc/collectd.d/10-write_riemann.conf',
                                               content: /Host "myhost"/,
                                               content: /Port "55555"/,
                                               content: /Protocol TCP/,
                                               content: /Batch false/,
                                               )
    end
  end

  context ':ensure => absent' do
    let :params do
      { riemann_host: ['myhost'], ensure: 'absent' }
    end
    it 'Will not create ' do
      should contain_file('write_riemann.load').with(ensure: 'absent',
                                               path: '/etc/collectd.d/10-write_riemann.conf',)
    end
  end

end
