require 'spec_helper'

describe 'collectd::plugin::exec::cmd', type: :define do
  let :facts do
    {
      osfamily: 'Debian',
      id: 'root',
      concat_basedir: '/dne',
      path: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context 'define a command' do
    let(:title) { 'whoami' }
    let :params do
      {
        user: 'www-data',
        group: 'users',
        exec: ['whoami', '--help']
      }
    end

    it 'executes whoami command' do
      is_expected.to contain_concat__fragment('collectd_plugin_exec_conf_whoami').with(content: %r{Exec "www-data:users" "whoami" "--help"},
                                                                                       target: '/etc/collectd/conf.d/exec-config.conf')
    end
  end

  context 'define a notification' do
    let(:title) { 'whoami' }
    let :params do
      {
        user: 'www-data',
        group: 'users',
        notification_exec: ['whoami', '--help']
      }
    end

    it 'executes whoami command' do
      is_expected.to contain_concat__fragment('collectd_plugin_exec_conf_whoami').with(content: %r{NotificationExec "www-data:users" "whoami" "--help"},
                                                                                       target: '/etc/collectd/conf.d/exec-config.conf')
    end
  end
end
