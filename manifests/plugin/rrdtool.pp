# https://collectd.org/wiki/index.php/Plugin:RRDtool
class collectd::plugin::rrdtool (
  $ensure           = present,
  $datadir          = '/var/lib/collectd/rrd',
  $createfilesasync = false,
  $rrarows          = 1200,
  $rratimespan      = [3600, 86400, 604800, 2678400, 31622400],
  $xff              = 0.1,
  $cacheflush       = 900,
  $cachetimeout     = 120,
  $writespersecond  = 50
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_string(
    $datadir
  )

  validate_bool(
    $createfilesasync
  )

  if $rrarows and ! is_integer($rrarows) {
    fail('rrarows must be an integer!')
  }

  validate_array(
    $rratimespan
  )

  if $xff and ! is_float($xff) {
    fail('xff must be a float!')
  }

  if $cacheflush and ! is_integer($cacheflush) {
    fail('cacheflush must be an integer!')
  }

  if $cachetimeout and ! is_integer($cachetimeout) {
    fail('cachetimeout must be an integer!')
  }

  if $writespersecond and ! is_integer($writespersecond) {
    fail('writespersecond must be an integer!')
  }

  file { 'rrdtool.conf':
    ensure    => $collectd::plugin::rrdtool::ensure,
    path      => "${conf_dir}/rrdtool.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/rrdtool.conf.erb'),
    notify    => Service['collectd'],
  }
}
