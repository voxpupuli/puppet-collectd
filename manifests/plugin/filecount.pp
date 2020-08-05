# https://collectd.org/wiki/index.php/Plugin:FileCount
class collectd::plugin::filecount (
  $ensure           = 'present',
  Hash $directories = {},
  $interval         = undef,
) {
  include collectd

  # We support two formats for directories:
  #  - new: hash for create_resources collectd::plugin::filecount::directory
  #  - old: backward compatibility, simple instance => path hash
  $values = values($directories)
  if size($values) > 0 and $values[0] =~ Hash {
    $content = undef
    $directories.each |String $resource, Hash $attributes| {
      collectd::plugin::filecount::directory { $resource:
        * => { ensure => $ensure } + $attributes,
      }
    }
  } else {
    $content = template('collectd/plugin/filecount.conf.erb')
  }

  collectd::plugin { 'filecount':
    ensure   => $ensure,
    content  => $content,
    interval => $interval,
  }
}
