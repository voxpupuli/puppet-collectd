require 'spec_helper'

describe 'collectd::plugin::netlink', :type => :class do
  let :facts do
    { :osfamily => 'RedHat' }
  end

  context ':ensure => present, specific params' do
    let :params do
      {
        :interfaces        => %w(eth0 eth1),
        :verboseinterfaces => ['ppp0'],
        :qdiscs            => ['"eth0" "pfifo_fast-1:0"', '"ppp0"'],
        :classes           => ['"ppp0" "htb-1:10"'],
        :filters           => ['"ppp0" "u32-1:0"'],
        :ignoreselected    => false,

      }
    end
    it 'Will create /etc/collectd.d/10-netlink.conf' do
      should contain_file('netlink.load').with(:ensure  => 'present',
                                               :path    => '/etc/collectd.d/10-netlink.conf',)
    end
    it { should contain_file('netlink.load').with_content(/^<Plugin netlink>$/) }
    it { should contain_file('netlink.load').with_content(/^  Interface "eth0"$/) }
    it { should contain_file('netlink.load').with_content(/^  Interface "eth1"$/) }
    it { should contain_file('netlink.load').with_content(/^  VerboseInterface "ppp0"$/) }
    it { should contain_file('netlink.load').with_content(/^  QDisc "eth0" "pfifo_fast-1:0"$/) }
    it { should contain_file('netlink.load').with_content(/^  QDisc "ppp0"$/) }
    it { should contain_file('netlink.load').with_content(/^  Class "ppp0" "htb-1:10"$/) }
    it { should contain_file('netlink.load').with_content(/^  Filter "ppp0" "u32-1:0"$/) }
    it { should contain_file('netlink.load').with_content(/^  IgnoreSelected false$/) }
    it do
      should contain_package('collectd-netlink').with(
        :ensure => 'present'
      )
    end
  end

  context ':ensure => absent' do
    let :params do
      { :interfaces => ['eth0'], :ensure => 'absent' }
    end
    it 'Will not create /etc/collectd.d/10-netlink.conf' do
      should contain_file('netlink.load').with(:ensure => 'absent',
                                               :path   => '/etc/collectd.d/10-netlink.conf',)
    end
    it do
      should contain_package('collectd-netlink').with(
        :ensure => 'absent'
      )
    end
  end

  context ':interfaces is not an array' do
    let :params do
      { :interfaces => 'eth0' }
    end
    it 'Will raise an error about :interfaces being a String' do
      should compile.and_raise_error(/String/)
    end
  end
end
