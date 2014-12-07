# https://collectd.org/wiki/index.php/Plugin:FileCount
class collectd::plugin::filecount (
  $ensure      = present,
  $directories = {},
  $interval    = undef,
) {
  validate_hash($directories)

  # We support two formats for directories:
  #  - new: hash for create_resources collectd::plugin::filecount::directory
  #  - old: backward compatibility, simple instance => path hash
  $values = values($directories)
  if size($values) > 0 and is_hash($values[0]) {
    $content = undef
    create_resources(collectd::plugin::filecount::directory, $directories, {ensure => $ensure})
  } else {
    $content = template('collectd/plugin/filecount.conf.erb')
  }

  collectd::plugin {'filecount':
    ensure   => $ensure,
    content  => $content,
    interval => $interval,
  }
}
