# Class: collectd::plugin::mongodb
#
class collectd::plugin::mongodb (
  $ensure         = 'present',
  $interval       = undef,
  $manage_package = true,
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

  if ( $db_host != undef ) and ( is_ip_address($db_host) == false ) {
    fail("collectd::plugin::mongodb::db_host is <${db_host}> and must be a valid IP address.")
  }

  if $db_user == undef {
    fail('collectd::plugin::mongodb::db_user is <undef> and must be a monodb username')
  }
  elsif $db_pass == undef {
    fail("collectd::plugin::mongodb::db_pass is <undef>, please specify the password for db user: ${db_user}")
  }

  if $::osfamily == 'Redhat' {
    if $manage_package == true {
      package { 'collectd-python':
        ensure          => $ensure,
        install_options => ['--nogpgcheck'],
      }
    }
  }

  collectd::plugin { 'mongodb':
    ensure   => $ensure,
    content  => template('collectd/plugin/mongodb.conf.erb'),
    interval => $interval,
    require  => File['mongodb.py'],
  }
}
