class collectd::service (
  $service_name   = $collectd::service_name,
  $service_ensure = $collectd::service_ensure,
  $service_enable = $collectd::service_enable,
  $manage_service = $collectd::manage_service,
) {

  if $manage_service {
    service { $service_name:
      ensure => $service_ensure,
      enable => $service_enable,
    }
  }

}
