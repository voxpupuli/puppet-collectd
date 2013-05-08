class collectd::plugin::interface (
  $interfaces,
  $ignoreselected = 'false'
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'interface.conf':
    path      => "${conf_dir}/interface.conf",
    ensure    => file,
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/interface.conf.erb'),
    notify    => Service['collectd']
  }
}
