require 'spec_helper'

describe 'collectd::plugin::snmp', :type => :class do
  let :facts do
    {:osfamily => 'RedHat'}
  end

  context ':ensure => present and dataset for AMAVIS-MIB::inMsgs.0' do
    let :params do
      {
        :data => {
          'amavis_incoming_messages' => {
            'Type'     => 'counter',
            'Table'    => false,
            'Instance' => 'amavis.inMsgs',
            'Values'   => ['AMAVIS-MIB::inMsgs.0']
          }
        },
        :hosts => {
          'scan04' => {
            'Address'   => '127.0.0.1',
            'Version'   => 2,
            'Community' => 'public',
            'Collect'   => ['amavis_incoming_messages'],
            'Interval'  => 10
          }
        },
      }
    end
    it 'Will create /etc/collectd.d/10-snmp.conf' do
      should contain_file('snmp.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/10-snmp.conf',
        :content => /Data "amavis_incoming_messages".+Instance "amavis.inMsgs".+Host "scan04".+Community "public"/m,
      })
    end
  end

  context ':ensure => absent' do
    let :params do
      {
        :ensure => 'absent',
        :data => {
          'amavis_incoming_messages' => {
            'Type'     => 'counter',
            'Table'    => false,
            'Instance' => 'amavis.inMsgs',
            'Values'   => ['AMAVIS-MIB::inMsgs.0']
          }
        },
        :hosts => {
          'scan04' => {
            'Address'   => '127.0.0.1',
            'Version'   => 2,
            'Community' => 'public',
            'Collect'   => ['amavis_incoming_messages'],
            'Interval'  => 10
          }
        },
      }
    end
    it 'Will not create /etc/collectd.d/10-snmp.conf' do
      should contain_file('snmp.load').with({
        :ensure => 'absent',
        :path   => '/etc/collectd.d/10-snmp.conf',
      })
    end
  end

  context ':data is not a hash' do
    let :params do
      {:data => []}
    end
    it 'Will raise an error about :data being a Array' do
      expect {should}.to raise_error(Puppet::Error,/Array/)
    end
  end
end

