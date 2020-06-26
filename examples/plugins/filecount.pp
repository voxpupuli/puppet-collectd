include collectd

class { 'collectd::plugin::filecount':
  directories => {
    'active'   => '/var/spool/postfix/active',
    'incoming' => '/var/spool/postfix/incoming',
  },
}

collectd::plugin::filecount::directory { 'foodir':
  path => '/path/to/dir',
}

collectd::plugin::filecount::directory { 'aborted-uploads':
  path          => '/var/spool/foo/upload',
  pattern       => '.part.*',
  mtime         => '5m',
  recursive     => true,
  includehidden => true,
}
