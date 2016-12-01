require 'spec_helper'

describe 'collectd::plugin::dbi', type: :class do
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

  context ':ensure => present and default parameters' do
    it 'Will create /etc/collectd/conf.d/10-dbi.conf to load the plugin' do
      is_expected.to contain_file('dbi.load').with(ensure: 'present',
                                                   path: '/etc/collectd/conf.d/10-dbi.conf',
                                                   content: %r{LoadPlugin dbi})
    end
    it 'Will create /etc/collectd.d/dbi-config.conf' do
      is_expected.to contain_concat('/etc/collectd/conf.d/dbi-config.conf').
        that_requires('File[collectd.d]')
      is_expected.to contain_concat__fragment('collectd_plugin_dbi_conf_header').with(content: %r{<Plugin dbi>})
    end
  end

  context ':ensure => present and create a db with a query' do
    let(:params) do
      {
        databases: {
          'mydatabase' => {
            'host'         => 'localhost',
            'driver'       => 'mysql',
            'driveroption' => {
              'host'     => 'db.example.com',
              'username' => 'dbuser',
              'password' => 'dbpasswd'
            },
            'selectdb' => 'db',
            'query'    => %w(disk_io log_delay)
          }
        },
        queries: {
          'log_delay' => {
            'statement' => 'SELECT * FROM log_delay_repli;',
            'results'   => [{
              'type'           => 'gauge',
              'instanceprefix' => 'log_delay',
              'instancesfrom'  => %w(inet_server_port inet_server_host),
              'valuesfrom'     => 'log_delay'
            }]
          }
        }
      }
    end

    it 'Will create /etc/collectd.d/dbi-config.conf' do
      is_expected.to contain_concat__fragment('collectd_plugin_dbi_conf_db_mydatabase').with(content: %r{Driver \"mysql\"\n})
      is_expected.to contain_concat__fragment('collectd_plugin_dbi_conf_db_mydatabase').with(content: %r{Host \"localhost\"\n})
      is_expected.to contain_concat__fragment('collectd_plugin_dbi_conf_db_mydatabase').with(content: %r{Query \"disk_io\"\n})
      is_expected.to contain_concat__fragment('collectd_plugin_dbi_conf_db_mydatabase').with(content: %r{DriverOption \"host\" \"db\.example\.com\"\n})
      is_expected.to contain_concat__fragment('collectd_plugin_dbi_conf_db_mydatabase').with(content: %r{DriverOption \"username\" \"dbuser\"\n})
      is_expected.to contain_concat__fragment('collectd_plugin_dbi_conf_db_mydatabase').with(content: %r{DriverOption \"password\" \"dbpasswd\"\n})

      is_expected.to contain_concat__fragment('collectd_plugin_dbi_conf_query_log_delay').with(content: %r{Statement \"SELECT \* FROM log_delay_repli;\"\n})
      is_expected.to contain_concat__fragment('collectd_plugin_dbi_conf_query_log_delay').with(content: %r{<Result>\n})
      is_expected.to contain_concat__fragment('collectd_plugin_dbi_conf_query_log_delay').with(content: %r{InstancesFrom \"inet_server_port\" \"inet_server_host\"\n})
      is_expected.to contain_concat__fragment('collectd_plugin_dbi_conf_query_log_delay').with(content: %r{ValuesFrom \"log_delay\"\n})
    end
  end
end
