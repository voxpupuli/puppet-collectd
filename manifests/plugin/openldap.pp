# https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_openldap
class collectd::plugin::openldap (
  $ensure = undef
  $instances  = { 'localhost' => { 'url' => 'ldap://localhost/' } },
  $interval   = undef,
) {

  include ::collectd

  validate_hash($instances)

  collectd::plugin { 'openldap':
    ensure   => $ensure_real,
    content  => template('collectd/plugin/openldap.conf.erb'),
    interval => $interval,
  }
}
