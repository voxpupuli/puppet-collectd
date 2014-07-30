require 'spec_helper'

describe 'collectd::plugin::rrdtool', :type => :class do
  let :facts do
    {:osfamily => 'RedHat'}
  end

  context ':ensure => present, default args' do
    it 'Will create /etc/collectd.d/10-rrdtool.conf' do
      should contain_file('rrdtool.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/10-rrdtool.conf',
        :content => /DataDir "\/var\/lib\/collectd\/rrd/,
      })
    end

   it { should contain_package('collectd-rrdtool').with(
     :ensure => 'present'
   )}

  end

  context ':ensure => absent' do
    let :params do
      {:ensure => 'absent'}
    end
    it 'Will not create /etc/collectd.d/10-rrdtool.conf' do
      should contain_file('rrdtool.load').with({
        :ensure => 'absent',
        :path   => '/etc/collectd.d/10-rrdtool.conf',
      })
    end
  end
end

