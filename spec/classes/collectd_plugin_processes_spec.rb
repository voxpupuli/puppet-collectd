require 'spec_helper'

describe 'collectd::plugin::processes', :type => :class do
  let :facts do
    {:osfamily => 'RedHat'}
  end

  context ':ensure => present, default params' do
    it 'Will create /etc/collectd.d/10-processes.conf' do
      should contain_file('processes.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/10-processes.conf',
        :content => //,
      })
    end
  end

  context ':ensure => present, specific params' do
    let :params do
      { :processes => [ 'process1'],
        :process_matches => [ 
          { 'name' => 'process-all',
            'regex' => 'process[0-9]' }
        ],
      }
    end

    it 'Will create /etc/collectd.d/10-processes.conf' do
      should contain_file('processes.load').with({
        :ensure  => 'present',
        :path    => '/etc/collectd.d/10-processes.conf',
        :content => /<Plugin "processes">\n\s*Process "process1"\n\s*ProcessMatch "process-all" "process\[0-9\]"\n<\/Plugin>/,
      })
    end
  end

  context ':ensure => absent' do
    let :params do
      {:ensure => 'absent'}
    end

    it 'Will not create /etc/collectd.d/10-processes.conf' do
      should contain_file('processes.load').with({
        :ensure => 'absent',
        :path   => '/etc/collectd.d/10-processes.conf',
      })
    end
  end
end

