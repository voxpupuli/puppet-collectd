require 'spec_helper'

describe 'collectd::plugin::iptables', :type => :class do
  let :facts do
    {:osfamily => 'RedHat'}
  end

  context ':ensure => present and :chains => { \'nat\' => \'In_SSH\' }' do
    let :params do
      {:chains => { 'nat' => 'In_SSH' }}
    end
    it 'Will create /etc/collectd.d/10-iptables.conf' do
      should contain_file('iptables.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/10-iptables.conf',
        :content => /Chain nat In_SSH/,
      })
    end
  end

  context ':ensure => absent' do
    let :params do
      {:chains => { 'nat' => 'In_SSH' }, :ensure => 'absent'}
    end
    it 'Will not create /etc/collectd.d/10-iptables.conf' do
      should contain_file('iptables.load').with({
        :ensure => 'absent',
        :path   => '/etc/collectd.d/10-iptables.conf',
      })
    end
  end

  context ':chains is not a hash' do
    let :params do
      {:chains => ['nat','In_SSH']}
    end
    it 'Will raise an error about :chains being an Array' do
      expect {should}.to raise_error(Puppet::Error,/Array/)
    end
  end
end

