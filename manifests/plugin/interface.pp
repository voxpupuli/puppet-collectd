class collectd::plugin::interface (
  $interfaces     = 'UNSET',
  $ignoreselected = 'false',
  $ensure         = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'interface.conf':
    ensure    => $collectd::plugin::interface::ensure,
    path      => "${conf_dir}/interface.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/interface.conf.erb'),
    notify    => Service['collectd']
  }
}
