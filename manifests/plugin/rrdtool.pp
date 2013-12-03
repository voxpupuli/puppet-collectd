# https://collectd.org/wiki/index.php/Plugin:RRDtool
class collectd::plugin::rrdtool (
  $ensure    = present
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'rrdtool.conf':
    ensure    => $collectd::plugin::rrdtool::ensure,
    path      => "${conf_dir}/rrdtool.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/rrdtool.conf.erb'),
    notify    => Service['collectd'],
  }
}
