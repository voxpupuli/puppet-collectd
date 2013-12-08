# https://collectd.org/wiki/index.php/Plugin:nginx
class collectd::plugin::nginx (
  $url,
  $ensure     = present,
  $user       = undef,
  $password   = undef,
  $verifypeer = undef,
  $verifyhost = undef,
  $cacert     = undef,
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'nginx.conf':
    ensure  => $collectd::plugin::nginx::ensure,
    path    => "${conf_dir}/nginx.conf",
    mode    => '0644',
    owner   => 'root',
    group   => $collectd::params::root_group,
    content => template('collectd/nginx.conf.erb'),
    notify  => Service['collectd']
  }
}
