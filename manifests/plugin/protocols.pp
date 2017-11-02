# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_protocols
class collectd::plugin::protocols (
  $ensure                 = 'present',
  Boolean $ignoreselected = false,
  Array $values           = []
) {

  include ::collectd

  collectd::plugin { 'protocols':
    ensure  => $ensure,
    content => template('collectd/plugin/protocols.conf.erb'),
  }
}
