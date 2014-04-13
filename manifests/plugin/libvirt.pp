# https://collectd.org/wiki/index.php/Plugin:libvirt
class collectd::plugin::libvirt (
  $connection,
  $ensure           = present,
  $refresh_interval = undef,
  $domain           = undef,
  $block_device     = undef,
  $interface_device = undef,
  $ignore_selected  = undef,
  $hostname_format  = undef,
  $interface_format = undef
) {
  validate_string($connection)

  if $refresh_interval != undef { validate_re($refresh_interval, '^\d+$') }
  if $domain != undef           { validate_string($domain) }
  if $block_device != undef     { validate_string($block_device) }
  if $interface_device != undef { validate_string($interface_device) }
  if $ignore_selected != undef  { validate_bool($ignore_selected) }
  if $hostname_format != undef  { validate_string($hostname_format) }
  if $interface_format != undef { validate_string($interface_format) }

  collectd::plugin { 'libvirt':
    ensure  => $ensure,
    content => template('collectd/plugin/libvirt.conf.erb'),
  }
}
