# https://collectd.org/wiki/index.php/Plugin:BIND
class collectd::plugin::bind (
  Stdlib::Httpurl $url,
  Enum['present', 'absent'] $ensure  = 'present',
  Boolean $manage_package            = $collectd::manage_package,
  Boolean $memorystats               = true,
  Boolean $opcodes                   = true,
  Boolean $parsetime                 = false,
  Boolean $qtypes                    = true,
  Boolean $resolverstats             = false,
  Boolean $serverstats               = true,
  Boolean $zonemaintstats            = true,
  Array[Collectd::Bind::View] $views = [],
  Optional[Integer[1]] $interval     = undef,
) {
  include collectd

  if $facts['os']['family'] == 'RedHat' {
    if $manage_package {
      package { 'collectd-bind':
        ensure => $ensure,
      }
    }
  }

  collectd::plugin { 'bind':
    ensure   => $ensure,
    content  => template('collectd/plugin/bind.conf.erb'),
    interval => $interval,
  }
}
