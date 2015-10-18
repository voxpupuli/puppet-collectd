# == Class: collectd::plugin::mongodb
#
# install and configure mongodb plugin
#
class collectd::plugin::mongodb (
  $db_host        = '127.0.0.1',
  $db_user        = undef,
  $db_pass        = undef,
  $db_port        = undef,
  $configured_dbs = undef,
  $collectd_dir   = '/usr/lib/collectd',
) {

  if $::osfamily == 'Redhat' {
    package { 'collectd-python':
      ensure          => $ensure,
      install_options => ['--nogpgcheck'],
    }
  }

  file { 'collectd_modulepath':
    ensure  => 'directory',
    path    => $collectd_dir,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Package['collectd-python'],
  }

  file { 'mongodb.py':
    ensure  => $ensure,
    path    => "${collectd_dir}/mongodb.py",
    source  => 'puppet:///modules/collectd/mongodb.py',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['collectd_modulepath'],
    notify  => Service['collectd'],
  }

  collectd::plugin { 'mongodb':
    ensure   => $ensure,
    content  => template('collectd/plugin/mongodb.conf.erb'),
    interval => $interval,
    require  => File['mongodb.py'],
  }
}
