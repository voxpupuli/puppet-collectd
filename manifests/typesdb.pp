define collectd::typesdb (
  $path = $title,
) {
  include collectd::params


  concat { $path:
    ensure         => present,
    owner          => 'root',
    group          => $collectd::params::root_group,
    mode           => '0640',
    ensure_newline => true,
    force          => true,
    notify         => Service['collectd'],
  }
}
