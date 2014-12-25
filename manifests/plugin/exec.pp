# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_exec
define collectd::plugin::exec (
  $user,
  $group,
  $exec              = [],
  $notification_exec = [],
  $ensure = present,
  $order = '10',
) {
  include collectd::params

  validate_array($exec)
  validate_array($notification_exec)

  $conf_dir = $collectd::params::plugin_conf_dir

  # This is deprecated file naming ensuring old style file removed, and should be removed in next major relese
  file { "${name}.load-deprecated":
    path => "${conf_dir}/${name}.conf",
    ensure => absent,
  }
  # End deprecation

  file {
    "${name}.load":
      ensure  => $ensure,
      path    => "${conf_dir}/${order}-${name}.conf",
      owner   => 'root',
      group   => $collectd::params::root_group,
      mode    => '0644',
      content => template('collectd/exec.conf.erb'),
      notify  => Service['collectd'],
  }

}
