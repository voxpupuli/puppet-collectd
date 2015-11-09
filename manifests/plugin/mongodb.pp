# Class: collectd::plugin::mongodb
#
class collectd::plugin::mongodb (
  $ensure         = 'present',
  $interval       = undef,
  $db_host        = '127.0.0.1',
  $db_user        = undef,
  $db_pass        = undef,
  $db_port        = undef,
  $configured_dbs = undef,
  $collectd_dir   = '/usr/lib/collectd',
) {

  validate_re($ensure,'^(present)|(absent)$',
    "collectd::plugin::mongodb::ensure is <${ensure}> and must be either 'present' or 'absent'.")

  if $interval != undef {
    validate_numeric($interval)
  }

  if $configured_dbs != undef {
    validate_array($configured_dbs)
    if ( $db_port == undef ) { fail('db_port is undefined, but must be set if configured_dbs is set.') }
    validate_string($db_port)
  }

  if ( $db_host != undef ) and ( is_ip_address($db_host) == false ) {
    fail("collectd::plugin::mongodb::db_host is <${db_host}> and must be a valid IP address.")
  }

  if $db_user == undef {
    fail('collectd::plugin::mongodb::db_user is <undef> and must be a mongodb username')
  }
  elsif $db_pass == undef {
    fail("collectd::plugin::mongodb::db_pass is <undef>, please specify the password for db user: ${db_user}")
  }

  collectd::plugin { 'mongodb':
    ensure   => $ensure,
    content  => template('collectd/plugin/mongodb.conf.erb'),
    interval => $interval,
  }
}
