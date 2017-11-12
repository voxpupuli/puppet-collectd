# https://collectd.org/wiki/index.php/Plugin:FileCount
define collectd::plugin::filecount::directory (
  Stdlib::Absolutepath $path,
  Enum['present', 'absent'] $ensure = 'present',
  String $instance                  = $name,
  Optional[String] $pattern         = undef,
  Optional[String] $mtime           = undef,
  Optional[String] $size            = undef,
  Optional[Boolean] $recursive      = undef,
  Optional[Boolean] $includehidden  = undef,
) {

  include ::collectd
  include ::collectd::plugin::filecount

  file { "${collectd::plugin_conf_dir}/15-filecount-${name}.conf":
    ensure  => $ensure,
    mode    => '0640',
    owner   => 'root',
    group   => $collectd::root_group,
    content => template('collectd/plugin/filecount-directory.conf.erb'),
    notify  => Service['collectd'],
  }
}
