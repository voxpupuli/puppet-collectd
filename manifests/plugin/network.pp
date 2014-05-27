# https://collectd.org/wiki/index.php/Plugin:Network
class collectd::plugin::network (
  $ensure        = present,
  $timetolive    = undef,
  $maxpacketsize = undef,
  $forward       = false,
  $reportstats   = false,
  $listeners     = { },
  $servers       = { },
) {
  validate_bool(
    $forward,
    $reportstats,
  )
  if $timetolive {
    validate_re($timetolive, '[0-9]+')
  }
  if $maxpacketsize {
    validate_re($maxpacketsize, '[0-9]+')
  }

  collectd::plugin {'network':
    ensure  => $ensure,
    content => template('collectd/plugin/network.conf.erb'),
  }
}
