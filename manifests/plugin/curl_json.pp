# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_curl_json
define collectd::plugin::curl_json (
  $url,
  $instance,
  $keys,
  $user     = undef,
  $password = undef,
) {

  include collectd::params
  validate_hash($keys)

  $conf_dir = $collectd::params::plugin_conf_dir

  file {
    "${name}.load":
      path    => "${conf_dir}/${name}.conf",
      owner   => 'root',
      group   => $collectd::params::root_group,
      mode    => '0644',
      content => template('collectd/curl_json.conf.erb'),
      notify  => Service['collectd'],
  }
}
