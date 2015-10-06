require 'spec_helper'

describe 'collectd::plugin::exec::cmd', :type => :define do
  let :facts do
    {
      :osfamily       => 'Debian',
      :id             => 'root',
      :concat_basedir => tmpfilename('collectd-exec'),
      :path           => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    }
  end

  context 'define a command' do
    let(:title) { 'whoami' }
    let :params do
      {
        :user  => 'www-data',
        :group => 'users',
        :exec  => ['whoami', '--help']
      }
    end

    it 'executes whoami command' do
      should contain_concat__fragment('collectd_plugin_exec_conf_whoami').with(:content => /Exec "www-data:users" "whoami" "--help"/,
                                                                               :target  => '/etc/collectd/conf.d/exec-config.conf',)
    end
  end

  context 'define a notification' do
    let(:title) { 'whoami' }
    let :params do
      {
        :user  => 'www-data',
        :group => 'users',
        :notification_exec => ['whoami', '--help']
      }
    end

    it 'executes whoami command' do
      should contain_concat__fragment('collectd_plugin_exec_conf_whoami').with(:content => /NotificationExec "www-data:users" "whoami" "--help"/,
                                                                               :target  => '/etc/collectd/conf.d/exec-config.conf',)
    end
  end
end
