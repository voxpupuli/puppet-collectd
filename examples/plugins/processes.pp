include collectd

class { 'collectd::plugin::processes':
  processes       => [ 'process1', 'process2' ],
  process_matches => [
    { name  => 'process-all',
      regex => 'process[0-9]' },
  ],
}
