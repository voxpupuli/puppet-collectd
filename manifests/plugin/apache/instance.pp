# https://collectd.org/wiki/index.php/Plugin:Apache
define collectd::plugin::apache::instance (
  Stdlib::Httpurl $url,
  String $ensure                         = present,
  Optional[String] $user                 = undef,
  Optional[String] $password             = undef,
  Optional[Boolean] $verifypeer          = undef,
  Optional[Boolean] $verifyhost          = undef,
  Optional[Stdlib::Absolutepath] $cacert = undef,
  Optional[String] $sslciphers           = undef,
  Optional[Integer] $timeout             = undef,
) {
  include collectd
  include collectd::plugin::apache

  file { "apache-instance-${name}.conf":
    ensure  => $ensure,
    path    => "${collectd::plugin_conf_dir}/25-apache-instance-${name}.conf",
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    mode    => $collectd::config_mode,
    content => template('collectd/plugin/apache/instance.conf.erb'),
    notify  => Service[$collectd::service_name],
  }
}
