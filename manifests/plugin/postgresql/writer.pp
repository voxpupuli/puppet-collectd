#
define collectd::plugin::postgresql::writer (
  $ensure           = 'present',
  String $statement = undef,
  $storerates       = undef,
) {
  include collectd
  include collectd::plugin::postgresql

  concat::fragment { "collectd_plugin_postgresql_conf_writer_${title}":
    order   => '40',
    target  => "${collectd::plugin_conf_dir}/postgresql-config.conf",
    content => template('collectd/plugin/postgresql/writer.conf.erb'),
  }
}
