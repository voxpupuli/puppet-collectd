#
define collectd::plugin::tail::file (
  Stdlib::Absolutepath $filename,
  String $instance,
  Array[Hash] $matches,
  $ensure = 'present',
) {

  include ::collectd
  include ::collectd::plugin::tail

  $conf_dir = $collectd::plugin_conf_dir

  file { "${name}.conf":
    ensure  => $ensure,
    path    => "${conf_dir}/tail-${name}.conf",
    mode    => '0644',
    owner   => 'root',
    group   => $collectd::root_group,
    content => template('collectd/tail-file.conf.erb'),
    notify  => Service['collectd'],
  }
}
