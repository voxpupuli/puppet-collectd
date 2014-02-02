# https://collectd.org/wiki/index.php/Plugin:Entropy
class collectd::plugin::entropy (
  $ensure           = present,
) {

  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'entropy.conf':
    ensure    => $collectd::plugin::entropy::ensure,
    path      => "${conf_dir}/entropy.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/entropy.conf.erb'),
    notify    => Service['collectd'],
  }

}
