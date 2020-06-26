class { 'collectd':
  purge_config => true,
  purge        => true,
  recurse      => true,
}

class { 'collectd::plugin::perl':
  order => 42,
}

collectd::plugin::perl::plugin { 'foo':
  include_dir => '/tmp',
  module      => 'Collectd::Plugins::Foo',
  provider    => 'file',
  source      => 'puppet:///modules/collectd/tests/Foo.pm',
  destination => '/tmp',
  order       => 99,
  config      => {
    'foo' => 'bar',
    'key' => ['val1', 'val2'],
  },
}

collectd::plugin::perl::plugin { 'bar':
  module          => 'B',
  enable_debugger => 'DProf',
  include_dir     => ['/tmp', '/tmp/lib'],
}

#collectd::plugin::perl {
#  'openafs_vos':
#    module        => 'Collectd::Plugins::OpenAFS::VOS',
#    provider      => 'cpan',
#    source        => 'Collectd::Plugins::OpenAFS',
#    config        => {'VosBin' => '/usr/afsws/etc/vos'},
#}

collectd::plugin::perl::plugin {
  'baar':
    module   => 'Collectd::Plugins::Bar',
    provider => 'package',
    source   => 'perl-Collectd-Plugins-Bar',
    config   => {
      'foo'  => 'bar',
      'more' => {
        'complex' => 'structure',
        'no'      => ['a', 'b'],
        'yes'     => {
          'last' => 'level',
          'and'  => ['array' , 'thing'],
        },
      },
    },
}
