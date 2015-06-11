include collectd

collectd::plugin::tail::file { 'exim-log':
  filename => '/var/log/exim4/mainlog',
  instance => 'exim',
  matches  => [
    {
      'regex'    => 'S=([1-9][0-9]*)',
      'dstype'   => 'CounterAdd',
      'type'     => 'ipt_bytes',
      'instance' => 'total',
    },
    {
      'regex'    => '\\<R=local_user\\>',
      'dstype'   => 'CounterInc',
      'type'     => 'counter',
      'instance' => 'local_user',
    }
  ]
}

collectd::plugin::tail::file { 'auth-log':
  filename => '/var/log/auth.log',
  instance => 'auth',
  matches  => [
    {
      'regex'    => '\\<sshd[^:]*: Accepted publickey for [^ ]+ from\\>',
      'dstype'   => 'CounterInc',
      'type'     => 'counter',
      'instance' => 'auth-publickey',
    }
  ]
}
