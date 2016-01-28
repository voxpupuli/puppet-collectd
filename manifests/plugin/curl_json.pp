# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_curl_json
define collectd::plugin::curl_json (
  $url,
  $instance,
  $keys,
  $ensure   = present,
  $user     = undef,
  $password = undef,
  $order = '10',
) {

  include ::collectd::params
  validate_hash($keys)

  if $::osfamily == 'Redhat' {
    ensure_packages('collectd-curl_json')
  }

  $conf_dir = $collectd::params::plugin_conf_dir

  # This is deprecated file naming ensuring old style file removed, and should be removed in next major relese
  file { "${name}.load-deprecated":
    ensure => absent,
    path   => "${conf_dir}/${name}.conf",
  }
  # End deprecation

  file {
    "${name}.load":
      path    => "${conf_dir}/${order}-${name}.conf",
      owner   => 'root',
      group   => $collectd::params::root_group,
      mode    => '0640',
      content => template('collectd/curl_json.conf.erb'),
      notify  => Service['collectd'],
  }
}
