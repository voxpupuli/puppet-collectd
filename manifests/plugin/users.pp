# https://collectd.org/wiki/index.php/Plugin:Users
class collectd::plugin::users (
  $ensure           = present,
) {

  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir

  file { 'users.conf':
    ensure    => $collectd::plugin::users::ensure,
    path      => "${conf_dir}/users.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/users.conf.erb'),
    notify    => Service['collectd'],
  }

}
