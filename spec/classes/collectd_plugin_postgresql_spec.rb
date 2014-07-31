require 'spec_helper'

describe 'collectd::plugin::postgresql', :type => :class do
  let :facts do
    {
        :osfamily => 'RedHat',
        :concat_basedir => tmpfilename('collectd-postgresql'),
        :id => 'root',
        :path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    }
  end

  context ':ensure => present and default parameters' do
    it 'Will create /etc/collectd.d/01-postgresql.conf to load the plugin' do
      should contain_file('postgresql.load').with({
                                                      :ensure  => 'present',
                                                      :path    => '/etc/collectd.d/10-postgresql.conf',
                                                      :content => /LoadPlugin postgresql/,
                                                  })
    end
    it 'Will create /etc/collectd.d/postgresql-config.conf' do
      should contain_concat__fragment('collectd_plugin_postgresql_conf_header').with({
                                                    :content => /<Plugin postgresql>/,
                                                })
    end
  end
  context ':ensure => present and create a db with a custom query' do
    let(:params) do
      {
        :databases => {
          'postgres' => {
            'host'     => 'localhost',
            'user'     => 'postgres',
            'password' => 'postgres',
            'sslmode'  => 'disable',
            'query'    => [ 'disk_io', 'log_delay' ],
          },
        },
        :queries => {
          'log_delay'=>{
            'statement' => 'SELECT * FROM log_delay_repli;',
            'results'   => [{
                'type'           => 'gauge',
                'instanceprefix' => 'log_delay',
                'instancesfrom'  => 'inet_server_port',
                'valuesfrom'     => 'log_delay',
              }],
            }
          },
        :writers => {
          'sqlstore'=>{
            'statement'  => 'SELECT collectd_insert($1, $2, $3, $4, $5, $6, $7, $8, $9);',
            'storerates' => true,
          }
        }
      }
    end
    it 'Will create /etc/collectd.d/postgresql-config.conf' do
      should contain_concat__fragment('collectd_plugin_postgresql_conf_db_postgres').with({
        :content => /Host \"localhost\"/,
                                                                                           })
      should contain_concat__fragment('collectd_plugin_postgresql_conf_db_postgres').with({
        :content => /Query \"disk_io\"/,
                                                                                          })
      should contain_concat__fragment('collectd_plugin_postgresql_conf_query_log_delay').with({
        :content => /Statement \"SELECT \* FROM log_delay_repli;\"\n/,
                                                                                          })
      should contain_concat__fragment('collectd_plugin_postgresql_conf_query_log_delay').with({
        :content => /<Result>\n/,
                                                                                              })
      should contain_concat__fragment('collectd_plugin_postgresql_conf_writer_sqlstore').with({
         :content => /<Writer sqlstore>\n/,
                                                                                              })
    end
  end

  context ':ensure => present and pool two db with the same name on different ports' do
    let(:params) do
      {
        :databases => {
          'postgres_port_5432' => {
            'instance' => 'postgres',
            'host'     => 'localhost',
            'user'     => 'postgres',
            'password' => 'postgres',
            'port'     => '5432',
            'sslmode'  => 'disable',
            'query'    => [ 'disk_io', 'log_delay' ],
          },
          'postgres_port_5433' => {
            'instance' => 'postgres',
            'host'     => 'localhost',
            'user'     => 'postgres',
            'password' => 'postgres',
            'port'     => '5433',
            'sslmode'  => 'disable',
            'query'    => [ 'disk_io', 'log_delay' ],

          },
        },
      }
    end
    it 'Will create /etc/collectd.d/postgresql-config.conf dsfd ' do
      should contain_concat__fragment('collectd_plugin_postgresql_conf_db_postgres_port_5432').with(
                 {
                     :content => /Instance \"postgres\"/,
                 }
             )
      should contain_concat__fragment('collectd_plugin_postgresql_conf_db_postgres_port_5433').with(
                 {
                     :content => /Instance \"postgres\"/,
                 }
             )
    end
  end
end
