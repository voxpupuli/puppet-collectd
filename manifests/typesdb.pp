define collectd::typesdb (
  $path = $title,
  $mode = '0640',
) {

  include ::collectd

  concat { $path:
    ensure         => present,
    owner          => 'root',
    group          => $::collectd::root_group,
    mode           => $mode,
    ensure_newline => true,
    notify         => Service['collectd'],
  }
}
