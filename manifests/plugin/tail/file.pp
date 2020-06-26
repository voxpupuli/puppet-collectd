#
define collectd::plugin::tail::file (
  Stdlib::Absolutepath $filename,
  String $instance,
  Array[Hash] $matches,
  $ensure = 'present',
) {
  include collectd
  include collectd::plugin::tail

  $conf_dir = $collectd::plugin_conf_dir

  file { "${name}.conf":
    ensure  => $ensure,
    path    => "${conf_dir}/tail-${name}.conf",
    mode    => $collectd::config_mode,
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    content => template('collectd/tail-file.conf.erb'),
    notify  => Service[$collectd::service_name],
  }
}
