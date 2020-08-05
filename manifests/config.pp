# private
class collectd::config inherits collectd {
  assert_private()

  $_conf_content = $collectd::purge_config ? {
    true    => template('collectd/collectd.conf.erb'),
    default => $collectd::conf_content,
  }

  file { 'collectd.conf':
    path    => $collectd::config_file,
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    mode    => $collectd::config_mode,
    content => $_conf_content,
  }

  if !$collectd::purge_config  and !$_conf_content {
    # former include of conf_d directory
    file_line { 'include_conf_d':
      ensure => absent,
      line   => "Include \"${collectd::plugin_conf_dir}/\"",
      path   => $collectd::config_file,
    }
    # include (conf_d directory)/*.conf
    file_line { 'include_conf_d_dot_conf':
      ensure => present,
      line   => "Include \"${collectd::plugin_conf_dir}/*.conf\"",
      path   => $collectd::config_file,
    }
  }

  file { 'collectd.d':
    ensure  => directory,
    path    => $collectd::plugin_conf_dir,
    mode    => $collectd::plugin_conf_dir_mode,
    owner   => $collectd::config_owner,
    group   => $collectd::config_group,
    purge   => $collectd::purge,
    recurse => $collectd::recurse,
  }

  File['collectd.d'] -> Concat <| tag == 'collectd' |>
}
