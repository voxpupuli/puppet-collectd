define collectd::plugin (
) {

$plugin = $name

file { "${plugin}.load":
    path    => "${conf_dir}/${plugin}.conf",
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => "LoadPlugin ${plugin}\n",
    notify  => Service['collectd'],
  }

}
