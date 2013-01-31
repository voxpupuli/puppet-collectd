define collectd::plugin (
  $ensure = 'present',
) {

$plugin = $name

file { "${plugin}.load":
    path    => "${conf_dir}/${plugin}.conf",
    ensure  => $ensure,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => "LoadPlugin ${plugin}\n",
    notify  => Service['collectd'],
  }

}
