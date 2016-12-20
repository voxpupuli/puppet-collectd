require 'spec_helper'

describe 'collectd::plugin::exec', type: :class do
  let :facts do
    {
      osfamily: 'Debian',
      concat_basedir: '/dne',
      id: 'root',
      kernel: 'Linux',
      path: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      collectd_version: '5.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context 'single command' do
    let :params do
      {
        commands: { 'hello' =>
          { 'user' => 'nobody', 'group' => 'users', 'exec' => ['/bin/echo', 'hello world'] } }
      }
    end

    it 'Will create /etc/collectd.d/conf.d/exec-config.conf' do
      is_expected.to contain_concat__fragment('collectd_plugin_exec_conf_header').
        with(content: %r{<Plugin exec>},
             target: '/etc/collectd/conf.d/exec-config.conf',
             order: '00')
    end

    it 'Will create /etc/collectd.d/conf.d/exec-config' do
      is_expected.to contain_concat('/etc/collectd/conf.d/exec-config.conf').
        that_requires('File[collectd.d]')
      is_expected.to contain_concat__fragment('collectd_plugin_exec_conf_footer').
        with(content: %r{</Plugin>},
             target: '/etc/collectd/conf.d/exec-config.conf',
             order: '99')
    end

    it 'includes exec statement' do
      is_expected.to contain_concat__fragment('collectd_plugin_exec_conf_hello').
        with(content: %r{Exec "nobody:users" "/bin/echo" "hello world"},
             target: '/etc/collectd/conf.d/exec-config.conf')
    end
  end

  context 'multiple commands' do
    let :params do
      {
        commands: {
          'hello' => { 'user' => 'nobody', 'group' => 'users',
                       'exec' => ['/bin/echo', 'hello world'] },
          'my_date' => { 'user' => 'nobody', 'group' => 'users',
                         'exec' => ['/bin/date'] }
        }
      }
    end

    it 'includes echo statement' do
      is_expected.to contain_concat__fragment('collectd_plugin_exec_conf_hello').
        with(content: %r{Exec "nobody:users" "/bin/echo" "hello world"},
             target: '/etc/collectd/conf.d/exec-config.conf')
    end

    it 'includes date statement' do
      is_expected.to contain_concat__fragment('collectd_plugin_exec_conf_my_date').
        with(content: %r{Exec "nobody:users" "/bin/date"},
             target: '/etc/collectd/conf.d/exec-config.conf')
    end
  end
end
