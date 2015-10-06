require 'spec_helper'

describe 'collectd::plugin::exec', :type => :class do
  let :facts do
    {
      :osfamily         => 'Debian',
      :concat_basedir   => tmpfilename('collectd-exec'),
      :id               => 'root',
      :kernel           => 'Linux',
      :path             => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      :collectd_version => '5.0'
    }
  end

  context 'single command' do
    let :params do
      {
        :commands => { 'hello' =>
          { 'user' => 'nobody', 'group' => 'users', 'exec' => ['/bin/echo', 'hello world'] }
        },
      }
    end

    it 'Will create /etc/collectd.d/conf.d/exec-config.conf' do
      should contain_concat__fragment('collectd_plugin_exec_conf_header')
        .with(:content => /<Plugin exec>/,
              :target  => '/etc/collectd/conf.d/exec-config.conf',
              :order   => '00')
    end

    it 'Will create /etc/collectd.d/conf.d/exec-config' do
      should contain_concat__fragment('collectd_plugin_exec_conf_footer')
        .with(:content => %r{</Plugin>},
              :target  => '/etc/collectd/conf.d/exec-config.conf',
              :order   => '99')
    end

    it 'includes exec statement' do
      should contain_concat__fragment('collectd_plugin_exec_conf_hello')
        .with(:content => %r{Exec "nobody:users" "/bin/echo" "hello world"},
              :target  => '/etc/collectd/conf.d/exec-config.conf',)
    end
  end

  context 'multiple commands' do
    let :params do
      {
        :commands => {
          'hello' => { 'user' => 'nobody', 'group' => 'users',
                       'exec' => ['/bin/echo', 'hello world']
          },
          'my_date' => { 'user' => 'nobody', 'group' => 'users',
                         'exec' => ['/bin/date']
          }
        },
      }
    end

    it 'includes echo statement' do
      should contain_concat__fragment('collectd_plugin_exec_conf_hello')
        .with(:content => %r{Exec "nobody:users" "/bin/echo" "hello world"},
              :target  => '/etc/collectd/conf.d/exec-config.conf',)
    end

    it 'includes date statement' do
      should contain_concat__fragment('collectd_plugin_exec_conf_my_date')
        .with(:content => %r{Exec "nobody:users" "/bin/date"},
              :target  => '/etc/collectd/conf.d/exec-config.conf',)
    end
  end
end
