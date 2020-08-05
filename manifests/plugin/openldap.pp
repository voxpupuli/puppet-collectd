# https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_openldap
class collectd::plugin::openldap (
  $ensure         = 'present',
  Hash $instances = { 'localhost' => { 'url' => 'ldap://localhost/' } },
  $interval       = undef,
) {
  include collectd

  collectd::plugin { 'openldap':
    ensure   => $ensure,
    content  => template('collectd/plugin/openldap.conf.erb'),
    interval => $interval,
  }
}
