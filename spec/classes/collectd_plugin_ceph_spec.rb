require 'spec_helper'

describe 'collectd::plugin::ceph', :type => :class do
  let :facts do
    { :osfamily => 'RedHat' }
  end

  context ':ensure => present and :osds => [ \'osd.0\, \osd.1\, \osd.2\]' do
    let :params do
      { :osds => ['osd.0', 'osd.1', 'osd.2'] }
    end
    content = <<EOS
<Plugin ceph>
  LongRunAvgLatency false
  ConvertSpecialMetricTypes true

  <Daemon "osd.0">
    SocketPath "/var/run/ceph/ceph-osd.0.asok"
  </Daemon>
  <Daemon "osd.1">
    SocketPath "/var/run/ceph/ceph-osd.1.asok"
  </Daemon>
  <Daemon "osd.2">
    SocketPath "/var/run/ceph/ceph-osd.2.asok"
  </Daemon>

</Plugin>
EOS
    it 'Will create /etc/collectd.d/10-ceph.conf' do
      should contain_collectd__plugin('ceph').with_content(content)
    end
  end

  context ':ensure => absent' do
    let :params do
      { :osds => ['osd.0', 'osd.1', 'osd.2'], :ensure => 'absent' }
    end
    it 'Will not create /etc/collectd.d/10-ceph.conf' do
      should contain_file('ceph.load').with(:ensure => 'absent',
                                            :path   => '/etc/collectd.d/10-ceph.conf',)
    end
  end

  context ':ceph is not an array' do
    let :params do
      { :osds => 'osd.0' }
    end
    it 'Will raise an error about :osds being a String' do
      should compile.and_raise_error(/String/)
    end
  end
end
