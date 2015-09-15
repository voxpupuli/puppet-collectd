# class used solely to test the collectd_version expansion in init.pp
# Note that fact collectd_real_version is also used by init.pp
# Write the generated value to a template so we can test it
class test::collectd_version(
  $version         = undef,
  $minimum_version = undef,
) {
  class { '::collectd':
    version         => $version,
    minimum_version => $minimum_version,
  }

  file { 'collectd_version.tmp':
    ensure  => file,
    path    => '/tmp/collectd_version.tmp',
    content => template('test/collectd_version.tmp.erb'),
    require => Class['Collectd'],
  }
}
