# https://collectd.org/wiki/index.php/Plugin:Apache
define collectd::plugin::apache::instance (
  $url,
  $ensure = present,
  $user = undef,
  $password = undef,
  $verifypeer = undef,
  $verifyhost = undef,
  $cacert = undef,
) {
  include ::collectd
  include ::collectd::plugin::apache

  $conf_dir = $collectd::params::plugin_conf_dir
  $root_group = $collectd::params::root_group

  file { "apache-instance-${name}.conf":
    ensure  => $ensure,
    path    => "${conf_dir}/25-apache-instance-${name}.conf",
    owner   => root,
    group   => $root_group,
    mode    => '0640',
    content => template('collectd/plugin/apache/instance.conf.erb'),
    notify  => Service['collectd'],
  }
}
