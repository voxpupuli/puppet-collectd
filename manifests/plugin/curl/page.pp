#
define collectd::plugin::curl::page (
  $ensure              = 'present',
  $url                 = undef,
  $user                = undef,
  $password            = undef,
  $verifypeer          = undef,
  $verifyhost          = undef,
  $cacert              = undef,
  $header              = undef,
  $post                = undef,
  $measureresponsetime = undef,
  $matches             = undef,
  $plugininstance      = $name, # You can have multiple <Page> with the same name.
) {

  include ::collectd
  include ::collectd::plugin::curl

  $conf_dir = $collectd::plugin_conf_dir

  validate_string($url)

  if $matches != undef {
    validate_array($matches)
  }

  file { "${conf_dir}/curl-${name}.conf":
    ensure  => $ensure,
    mode    => '0640',
    owner   => 'root',
    group   => $collectd::root_group,
    content => template('collectd/plugin/curl-page.conf.erb'),
    notify  => Service['collectd'],
  }
}
