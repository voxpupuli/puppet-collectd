class collectd::service (
  $service_name   = $collectd::service_name,
  $service_ensure = $collectd::service_ensure,
  $service_enable = $collectd::service_enable,
) {

  service { 'collectd':
    ensure => $service_ensure,
    name   => $service_name,
    enable => $service_enable,
  }

}
