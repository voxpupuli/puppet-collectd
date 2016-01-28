define collectd::typesdb (
  $path = $title,
  $mode = '0640',
) {
  include ::collectd::params


  concat { $path:
    ensure         => present,
    owner          => 'root',
    group          => $collectd::params::root_group,
    mode           => $mode,
    ensure_newline => true,
    force          => true,
    notify         => Service['collectd'],
  }
}
