#
define collectd::plugin::curl::page (
  String $url,
  String $ensure                         = 'present',
  Optional[String] $user                 = undef,
  Optional[String] $password             = undef,
  Optional[Boolean] $verifypeer          = undef,
  Optional[Boolean] $verifyhost          = undef,
  Optional[Stdlib::Absolutepath] $cacert = undef,
  Optional[String] $header               = undef,
  Optional[Boolean] $measureresponsetime = undef,
  Optional[Boolean] $measureresponsecode = undef,
  Optional[Array[Hash]] $matches         = undef,
  String $plugininstance                 = $name, # You can have multiple <Page> with the same name.
) {
  include collectd
  include collectd::plugin::curl

  $conf_dir = $collectd::plugin_conf_dir

  file { "${conf_dir}/curl-${name}.conf":
    ensure  => $ensure,
    mode    => $collectd::config_mode,
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    content => template('collectd/plugin/curl-page.conf.erb'),
    notify  => Service[$collectd::service_name],
  }
}
