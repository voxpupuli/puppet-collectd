define collectd::plugin (
  $ensure = 'present',
) {

include collectd::params

$plugin = $name
$conf_dir = $collectd::params::plugin_conf_dir

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
