#https://collectd.org/documentation/manpages/collectd.conf.5.shtml#plugin_tail_csv
class collectd::plugin::tail_csv (
  Hash[String, Collectd::Tail_Csv::Metric, 1] $metrics,
  Hash[String, Collectd::Tail_Csv::File, 1] $files,
  Enum['present', 'absent'] $ensure = 'present',
  Integer $order                    = 10,
) {
  include collectd

  collectd::plugin { 'tail_csv':
    ensure  => $ensure,
    content => epp('collectd/plugin/tail_csv.conf.epp'),
    order   => $order,
  }
}
