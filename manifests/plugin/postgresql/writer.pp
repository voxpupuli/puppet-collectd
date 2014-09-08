#
define collectd::plugin::postgresql::writer (
  $ensure     = 'present',
  $statement  = undef,
  $storerates = undef,
){
  include collectd::params
  include collectd::plugin::postgresql

  validate_string($statement)

  concat::fragment{"collectd_plugin_postgresql_conf_writer_${title}":
    ensure  => $ensure,
    order   => '40',
    target  => "${collectd::params::plugin_conf_dir}/postgresql-config.conf",
    content => template('collectd/plugin/postgresql/writer.conf.erb'),
  }
}
