# See http://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_protocols
class collectd::plugin::protocols (
  $ensure = 'present',
  Optional[Boolean] $ignoreselected = undef,
  Array $values = []
) {
  include collectd

  collectd::plugin { 'protocols':
    ensure  => $ensure,
    content => template('collectd/plugin/protocols.conf.erb'),
  }
}
