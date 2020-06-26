define collectd::typesdb (
  $path  = $title,
  $group = $collectd::config_group,
  $mode  = $collectd::config_mode,
  $owner = $collectd::config_owner,
) {
  include collectd

  concat { $path:
    ensure         => present,
    owner          => $owner,
    group          => $group,
    mode           => $mode,
    ensure_newline => true,
    notify         => Service[$collectd::service_name],
  }
}
