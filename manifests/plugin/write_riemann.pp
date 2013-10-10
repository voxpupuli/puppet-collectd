# https://collectd.org/wiki/index.php/Plugin:Write_Riemann

class collectd::plugin::write_riemann (
  $ensure           = present,
  $riemann_host     = 'localhost',
  $riemann_port     = 5555,
  $protocol         = 'UDP',
  $store_rates      = false,
  $always_append_ds = false,
) {
  include collectd::params

  $conf_dif = $collectd::params::plugin_conf_dir
  validate_bool($store_rates)
  validate_bool($always_append_ds)

  file { 'write_riemann.conf':
    ensure  => $collectd::plugin::write_riemann::ensure,
    path    => "${conf_dif}/write_riemann.conf",
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('collectd/write_riemann.conf.erb'),
    notify  => Service['collectd'],
  }
}

