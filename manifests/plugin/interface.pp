# https://collectd.org/wiki/index.php/Plugin:Interface
class collectd::plugin::interface (
  $ensure         = present,
  $interfaces     = [],
  $ignoreselected = false,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_array($interfaces)
  validate_bool($ignoreselected)

  file { 'interface.conf':
    ensure    => $collectd::plugin::interface::ensure,
    path      => "${conf_dir}/interface.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/interface.conf.erb'),
    notify    => Service['collectd']
  }
}
