class collectd::service (
  $service_name   = $collectd::service_name,
  $service_ensure = $collectd::service_ensure,
  $service_enable = $collectd::service_enable,
  $manage_service = $collectd::manage_service,
) {

  if $manage_service {
    service { 'collectd':
      ensure => $service_ensure,
      name   => $service_name,
      enable => $service_enable,
    }
  }

}
