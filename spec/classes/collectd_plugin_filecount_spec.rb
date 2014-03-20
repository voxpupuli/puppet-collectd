require 'spec_helper'

describe 'collectd::plugin::filecount', :type => :class do
  let :facts do
    {:osfamily => 'RedHat'}
  end

  context ':ensure => present and :directories => { \'active\' => \'/var/spool/postfix/active\' }' do
    let :params do
      {:directories => { 'active' => '/var/spool/postfix/active' }}
    end
    it 'Will create /etc/collectd.d/10-filecount.conf' do
      should contain_file('filecount.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/10-filecount.conf',
        :content => /Directory "\/var\/spool\/postfix\/active"/,
      })
    end
  end

  context ':ensure => absent' do
    let :params do
      {:directories => { 'active' => '/var/spool/postfix/active' }, :ensure => 'absent'}
    end
    it 'Will not create /etc/collectd.d/10-filecount.conf' do
      should contain_file('filecount.load').with({
        :ensure => 'absent',
        :path   => '/etc/collectd.d/10-filecount.conf',
      })
    end
  end

  context ':directories is not hash' do
    let :params do
      {:directories => '/var/spool/postfix/active'}
    end
    it 'Will raise an error about :directories being a String' do
      expect {should}.to raise_error(Puppet::Error,/String/)
    end
  end
end

