#
define collectd::plugin (
  $ensure   = 'present',
  $content  = undef,
  $order    = '10',
  $globals  = false,
  $interval = undef,
  $plugin   = $name
) {

  include ::collectd::params
  $conf_dir = $collectd::params::plugin_conf_dir
  $root_group = $collectd::params::root_group

  file { "${plugin}.load":
    ensure  => $ensure,
    path    => "${conf_dir}/${order}-${plugin}.conf",
    owner   => root,
    group   => $root_group,
    mode    => '0640',
    content => template('collectd/loadplugin.conf.erb'),
    notify  => Service['collectd'],
  }

  # Older versions of this module didn't use the "00-" prefix.
  # Delete those potentially left over files just to be sure.
  file { "older_${plugin}.load":
    ensure => absent,
    path   => "${conf_dir}/${plugin}.conf",
    notify => Service['collectd'],
  }

  # Older versions of this module use the "00-" prefix by default.
  # Delete those potentially left over files just to be sure.
  if $order != '00' {
    file { "old_${plugin}.load":
      ensure => absent,
      path   => "${conf_dir}/00-${plugin}.conf",
      notify => Service['collectd'],
    }
  }
}
