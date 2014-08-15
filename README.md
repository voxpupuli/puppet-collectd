Collectd module for Puppet
==========================

[![Build Status](https://travis-ci.org/pdxcat/puppet-module-collectd.png?branch=master)](https://travis-ci.org/pdxcat/puppet-module-collectd)

Description
-----------

Puppet module for configuring collectd and plugins.

Usage
-----

The simplest use case is to use all of the configurations in
the default collectd.conf file shipped with collectd. This can
be done by simply including the class:

```puppet
include collectd
```

Collectd is most useful when configured with customized plugins.
This is accomplished by removing the default collectd.conf file
and replacing it with a file that includes all alternative
configurations. Configure a node with the following class
declaration:

```puppet
class { '::collectd':
  purge        => true,
  recurse      => true,
  purge_config => true,
}
```

Set purge, recurse, and purge_config to true in order to override
the default configurations shipped in collectd.conf and use
custom configurations stored in conf.d. From here you can set up
additional plugins as shown below.

Simple Plugins
--------------

Example of how to load plugins with no additional configuration:

```puppet
collectd::plugin { 'battery': }
```

where 'battery' is the name of the plugin.

Configurable Plugins
------------------

Parameters will vary widely between plugins. See the collectd
documentation for each plugin for configurable attributes.

* `amqp`  (see [collectd::plugin::amqp](#class-collectdpluginamqp) below)
* `apache`  (see [collectd::plugin::apache](#class-collectdpluginapache) below)
* `bind`  (see [collectd::plugin::bind](#class-collectdpluginbind) below)
* `cpu`  (see [collectd::plugin::cpu](#class-collectdplugincpu) below)
* `csv`  (see [collectd::plugin::csv](#class-collectdplugincsv) below)
* `curl` (see [collectd::plugin::curl](#class-collectdplugincurl) below)
* `curl_json` (see [collectd::plugin::curl_json](#class-collectdplugincurl_json) below)
* `df`  (see [collectd::plugin::df](#class-collectdplugindf) below)
* `disk` (see [collectd::plugin::disk](#class-collectdplugindisk) below)
* `entropy`  (see [collectd::plugin::entropy](#class-collectdpluginentropy) below)
* `exec`  (see [collectd::plugin::exec](#class-collectdpluginexec) below)
* `filecount` (see [collectd::plugin::filecount](#class-collectdpluginfilecount) below)
* `interface` (see [collectd::plugin::interface](#class-collectdplugininterface) below)
* `iptables` (see [collectd::plugin::iptables](#class-collectdpluginiptables) below)
* `irq` (see [collectd::plugin::irq](#class-collectdpluginirq) below)
* `load` (see [collectd::plugin::load](#class-collectdpluginload) below)
* `logfile` (see [collectd::plugin::logfile](#class-collectdpluginlogfile) below)
* `libvirt` (see [collectd::plugin::libvirt](#class-collectdpluginlibvirt) below)
* `memcached`(see [collectd::plugin::memcached](#class-collectdpluginmemcached) below )
* `memory`(see [collectd::plugin::memory](#class-collectdpluginmemory) below )
* `mysql` (see [collectd::plugin::mysql](#class-collectdpluginmysql) below)
* `network` (see [collectd::plugin::network](#class-collectdpluginnetwork) below)
* `nfs`  (see [collectd::plugin::nfs](#class-collectdpluginnfs) below)
* `nginx` (see [collectd::plugin::nginx](#class-collectdpluginnginx) below)
* `ntpd` (see [collectd::plugin::ntpd](#class-collectdpluginntpd) below)
* `openvpn` (see [collectd::plugin::openvpn](#class-collectdpluginopenvpn) below)
* `perl` (see [collectd::plugin::perl](#class-collectdpluginperl) below)
* `ping` (see [collectd::plugin::ping](#class-collectdpluginping) below)
* `postgresql` (see [collectd::plugin::postgresql](#class-collectdpluginpostgresql) below)
* `processes` (see [collectd::plugin:processes](#class-collectdpluginprocesses) below)
* `python` (see [collectd::plugin::python](#class-collectdpluginpython) below)
* `redis` (see [collectd::plugin::redis](#class-collectdpluginredis) below)
* `rrdcached` (see [collectd::plugin::rrdcached](#class-collectdpluginrrdcached) below)
* `rrdtool` (see [collectd::plugin::rrdtool](#class-collectdpluginrrdtool) below)
* `sensors` (see [collectd::plugin::sensors](#class-collectdpluginsensors) below)
* `snmp` (see [collectd::plugin::snmp](#class-collectdpluginsnmp) below)
* `statsd` (see [collectd::plugin::statsd](#class-collectdpluginstatsd) below)
* `swap` (see [collectd::plugin::swap](#class-collectdpluginswap) below)
* `syslog` (see [collectd::plugin::syslog](#class-collectdpluginsyslog) below)
* `tail` (see [collectd::plugin::tail](#class-collectdplugintail) below)
* `tcpconns` (see [collectd::plugin::tcpconns](#class-collectdplugintcpconns) below)
* `unixsock` (see [collectd::plugin::unixsock](#class-collectdpluginunixsock) below)
* `uptime` (see [collectd::plugin::uptime](#class-collectdpluginuptime) below)
* `users` (see [collectd::plugin::users](#class-collectdpluginusers) below)
* `varnish` (see [collectd::plugin::varnish](#class-collectdpluginvarnish) below)
* `vmem` (see [collectd::plugin::vmem](#class-collectdpluginvmem) below)
* `write_graphite` (see [collectd::plugin::write_graphite](#class-collectdpluginwrite_graphite) below)
* `write_http` (see [collectd::plugin::write_http](#class-collectdpluginwrite_http) below)
* `write_network` (see [collectd::plugin::write_network](#class-collectdpluginwrite_network) below)
* `write_riemann` (see [collectd::plugin::write_riemann](#class-collectdpluginwrite_riemann) below)

####Class: `collectd::plugin::amqp`

```puppet
class { 'collectd::plugin::amqp':
  amqphost => '127.0.0.1',
  amqpvhost => 'myvirtualhost',
  graphiteprefix => 'collectdmetrics',
  amqppersistent => true,
}
```

####Class: `collectd::plugin::apache`

```puppet
class { 'collectd::plugin::apache':
  instances => {
    'apache80' => {
      'url' => 'http://localhost/mod_status?auto', 'user' => 'collectd', 'password' => 'hoh2Coo6'
    },
    'lighttpd8080' => {
      'url' => 'http://localhost:8080/mod_status?auto'
    }
  },
}
```

####Class: `collectd::plugin::bind`

```puppet
class { 'collectd::plugin::bind':
  url    => 'http://localhost:8053/',
}
```

####Class: `collectd::plugin::cpu`

```puppet
class { 'collectd::plugin::cpu':
}
```

####Class: `collectd::plugin::csv`

```puppet
class { 'collectd::plugin::csv':
  datadir    => '/etc/collectd/var/lib/collectd/csv',
  storerates => false,
}
```

####Class: `collectd::plugin::curl`

```puppet
collectd::plugin::curl::page {
  'stock_quotes':
    url      => 'http://finance.google.com/finance?q=NYSE%3AAMD',
    user     => 'foo',
    password => 'bar',
    matches  => [
      {
        'dstype'   => 'GaugeAverage',
        'instance' => 'AMD',
        'regex'    => ']*> *([0-9]*\\.[0-9]+) *',
        'type'     => 'stock_value',
      }],
}
```

You can as well configure this plugin with a parameterized class : 

```puppet
class { 'collectd::plugin::curl':
  pages => {
    'stock_GM' => {
      url      => 'http://finance.google.com/finance?q=NYSE%3AGM',
      user     => 'foo',
      password => 'bar',
      matches  => [
        {
          'dstype'   => 'GaugeAverage',
          'instance' => 'AMD',
          'regex'    => ']*> *([0-9]*\\.[0-9]+) *',
          'type'     => 'stock_value',
        },
      ],
    },
  },
}
```

####Class: `collectd::plugin::curl_json`

```puppet
collectd::plugin::curl_json {
  'rabbitmq_overview':
    url => 'http://localhost:55672/api/overview',
    instance => 'rabbitmq_overview',
    keys => {
      'message_stats/publish' => {'type' => 'gauge'},
    }
}
```

####Class: `collectd::plugin::df`

```puppet
class { 'collectd::plugin::df':
  mountpoints    => ['/u'],
  fstypes        => ['nfs','tmpfs','autofs','gpfs','proc','devpts'],
  ignoreselected => true,
}
```

####Class: `collectd::plugin::disk`

```puppet
class { 'collectd::plugin::disk':
  disks          => ['/^dm/'],
  ignoreselected => true
}
```

####Class: `collectd::plugin::entropy`

```puppet
collectd::plugin::entropy {
}
```

####Class: `collectd::plugin::exec`

```puppet
collectd::plugin::exec {
  'dummy':
    user => nobody,
    group => nogroup,
    exec => ["/bin/echo", "PUTVAL myhost/foo/gauge-flat N:1"],
}
```

####Class: `collectd::plugin::filecount`

```puppet
class { 'collectd::plugin::filecount':
  directories => {
    'active'   => '/var/spool/postfix/active',
    'incoming' => '/var/spool/postfix/incoming'
  },
}
```
####Class: `collectd::plugin::interface`

```puppet
class { 'collectd::plugin::interface':
  interfaces     => ['lo'],
  ignoreselected => true
}
```

####Class: `collectd::plugin::irq`

```puppet
class { 'collectd::plugin::irq':
  irqs           => ['7', '23'],
  ignoreselected => true,
}
```

####Class: `collectd::plugin::iptables`

```puppet
class { 'collectd::plugin::iptables':
  chains  => {
    'nat'    => 'In_SSH',
    'filter' => 'HTTP'
  },
}
```

####Class: `collectd::plugin::load`

```puppet
class { 'collectd::plugin::load':
}
```

####Class: `collectd::plugin::logfile`

```puppet
class { 'collectd::plugin::logfile':
  log_level => 'warning',
  log_file => '/var/log/collected.log'
}
```

####Class: `collectd::plugin::libvirt`

The interface_format parameter was introduced in collectd 5.0 and will
therefore be ignored (with a warning) when specified with older versions.

```puppet
class { 'collectd::plugin::libvirt':
  connection       => 'qemu:///system',
  interface_format => 'address'
}
```

####Class: `collectd::plugin::memcached`

```puppet
class { 'collectd::plugin::memcached':
  host => '192.168.122.1',
  port => 11211,
}
```

####Class: `collectd::plugin::memory`

```puppet
class { 'collectd::plugin::memory':
}
```

####Class: `collectd::plugin::mysql`

```puppet
collectd::plugin::mysql::database { 'betadase':
  host        => 'localhost',
  username    => 'stahmna',
  password    => 'secret',
  port        => '3306',
  masterstats => true,
}
```

####Class: `collectd::plugin::network`

```puppet
collectd::plugin::network::server{'hostname':
  port => 25826,
}

collectd::plugin::network::listener{'hostname':
  port => 25826,
}
```

You can as well configure this plugin with a parameterized class : 

```puppet
class { 'collectd::plugin::network':
  timetolive    => '70',
  maxpacketsize => '42',
  forward       => false,
  reportstats   => true,
  servers       => { 'hostname' => {
    'port'          => '25826',
    'interface'     => 'eth0',
    'securitylevel' => '',
    'username'      => 'foo',
    'password'      => 'bar',},
  },
  listeners     => { 'hostname' => {
    'port'          => '25826',
    'interface'     => 'eth0',
    'securitylevel' => '',
    'authfile'      => '/etc/collectd/passwd',},
  },
}
```

####Class: `collectd::plugin::nfs`

```puppet
class { 'collectd::plugin::nfs':
}
```

####Class: `collectd::plugin::nginx`

```puppet
class { 'collectd::plugin::nginx':
  url      => 'https://localhost:8433',
  user     => 'stats',
  password => 'uleePi4A',
}
```

####Class: `collectd::plugin::ntpd`

```puppet
class { 'collectd::plugin::ntpd':
  host           => 'localhost',
  port           => 123,
  reverselookups => false,
  includeunitid  => false,
}
```

####Class: `collectd::plugin::openvpn`

```puppet
class { 'collectd::plugin::openvpn':
  collectindividualusers => false,
  collectusercount       => true,
}
```

####Class: `collectd::plugin::perl`

This class has no parameters and will load the actual perl plugin.
It will be automatically included if any `perl::plugin` is defined.

#####Example:
```puppet
include collectd::plugin::perl
```

####Define: `collectd::plugin::perl::plugin`

This define will load a new perl plugin.

#####Parameters:

* `module` (String): name of perl module to load (mandatory)
* `enable_debugger` (False or String): whether to load the perl debugger. See *collectd-perl* manpage for more details. 
* `include_dir` (String or Array): directories to add to *@INC*
* `provider` (`"package"`,`"cpan"`,`"file"` or `false`): method to get the plugin code
* `source` (String): this parameter is consumed by the provider to infer the source of the plugin code
* `destination (String or false): path to plugin code if `provider` is `file`. Ignored otherwise.
* `order` (String containing numbers): order in which the plugin should be loaded. Defaults to `"00"`
* `config` (Hash): plugin configuration in form of a hash. This will be converted to a suitable structure understood by *liboconfig* which is the *collectd* configuration parser. Defaults to `{}`

#####Examples:

######Using a preinstalled plugin:
```puppet
collectd::plugin::perl::plugin { 'foo':
    module          => 'Collectd::Plugins::Foo',
    enable_debugger => "",
    include_dir     => '/usr/lib/collectd/perl5/lib',
}
```

######Using a plugin from a file from *source*:
```puppet
collectd::plugin::perl::plugin { 'baz':
    module      => 'Collectd::Plugins::Baz',
    provider    => 'file',
    source      => 'puppet:///modules/myorg/baz_collectd.pm',
    destination => '/path/to/my/perl5/modules'
}
```

######Using a plugin from cpan (requires the [puppet cpan module](https://forge.puppetlabs.com/meltwater/cpan)):
```puppet
collectd::plugin::perl::plugin {
  'openafs_vos':
    module        => 'Collectd::Plugins::OpenAFS::VOS',
    provider      => 'cpan',
    source        => 'Collectd::Plugins::OpenAFS',
    config        => {'VosBin' => '/usr/afsws/etc/vos'},
}
```

######Using a plugin from package source:
```puppet
collectd::plugin::perl::plugin {
  'bar':
    module        => 'Collectd::Plugins::Bar',
    provider      => 'package',
    source        => 'perl-Collectd-Plugins-Bar',
    config        => {'foo' => 'bar'},
}
```

####Class: `collectd::plugin::ping`

```puppet
collectd::plugin::ping {
  'example':
    hosts => ['example.com'],
}
```

####Class: `collectd::plugin::postgresql`

```puppet
collectd::plugin::postgresql::database{'monitoring_node1':
  name     => 'monitoring',
  port     => '5433',
  instance => 'node1',
  host     => 'localhost',
  user     => 'collectd',
  password => 'collectd',
  query    => 'log_delay',
}
collectd::plugin::postgresql::query{'log_delay':
  statement => 'SELECT * FROM log_delay_repli;',
  results   => [{
    type           => 'gauge',
    instanceprefix => 'log_delay',
    instancesfrom  => 'inet_server_port',
    valuesfrom     => 'log_delay',
  }],
}
collectd::plugin::postgresql::writer{'sqlstore':
  statement  => 'SELECT collectd_insert($1, $2, $3, $4, $5, $6, $7, $8, $9);',
  storerates => 'true',
}
```

You can as well configure this plugin as a parameterized class :

```puppet
class { 'collectd::plugin::postgresql':
  databases => {
    'postgres' => {
      'host'     => '/var/run/postgresql/',
      'user'     => 'postgres',
      'password' => 'postgres',
      'sslmode'  => 'disable',
      'query'    => [ 'query_plans', 'queries', 'table_states', 'disk_io' ],
    },
    'devdb' => {
      'host'     => 'host.example.com',
      'port'     => '5432',
      'user'     => 'postgres',
      'password' => 'secret',
      'sslmode'  => 'prefer',
    }
  }
}
```

####Class: `collectd::plugin::processes`

```puppet
class { 'collectd::plugin::processes':
  processes => ['process1', 'process2'],
  process_matches => [
    { name => 'process-all', regex => 'process.*' }
  ],
}
```

####Class: `collectd::plugin::python`

```puppet
collectd::plugin::python {
  'elasticsearch':
    modulepath    => '/usr/lib/collectd',
    module        => 'elasticsearch',
    script_source => 'puppet:///modules/myorg/elasticsearch_collectd_python.py',
    config        => {'Cluster' => 'elasticsearch'},
}
```

####Class: `collectd::plugin::redis`

```puppet
class { 'collectd::plugin::redis':
  nodes => {
    'node1' => {
      'host'     => 'localhost',
    },
    'node2' => {
      'host'     => 'node2.example.com',
      'port'     => '6380',
      'timeout'  => 3000,
    }
  }
}
```

####Class: `collectd::plugin::rrdcached`

```puppet
class { 'collectd::plugin::rrdcached':
  daemonaddress => 'unix:/var/run/rrdcached.sock',
  datadir       => '/var/lib/rrdcached/db/collectd',
}
```

####Class: `collectd::plugin::rrdtool`

```puppet
class { 'collectd::plugin::rrdtool':
  datadir           => '/var/lib/collectd/rrd',
  createfilesasync  => false,
  rrarows           => 1200,
  rratimespan       => [3600, 86400, 604800, 2678400, 31622400],
  xff               => 0.1,
  cacheflush        => 900,
  cachetimeout      => 120,
  writespersecond   => 50
}
```

####Class: `collectd::plugin::sensors`

```puppet
class {'collectd::plugin::sensors':
  ignoreselected => false,
}
```

####Class: `collectd::plugin::snmp`

```puppet
class {'collectd::plugin::snmp':
  data  =>  {
    amavis_incoming_messages => {
      'Type'     => 'counter',
      'Table'    => false,
      'Instance' => 'amavis.inMsgs',
      'Values'   => ['AMAVIS-MIB::inMsgs.0']
    }
  },
  hosts => {
    debianvm => {
      'Address'   => '127.0.0.1',
      'Version'   => 2,
      'Community' => 'public',
      'Collect'   => ['amavis_incoming_messages'],
      'Interval'  => 10
    }
  },
}
```

####Class: `collectd::plugin::statsd`

```puppet
class { 'collectd::plugin::statsd':
  host            => '0.0.0.0',
  port            => 8125,
  deletecounters  => false,
  deletetimers    => false,
  deletegauges    => false,
  deletesets      => false,
  timerpercentile => 50,
}
```

####Class: `collectd::plugin::swap`

```puppet
class { 'collectd::plugin::swap':
  reportbydevice => false,
  reportbytes    => true
}
```

####Class: `collectd::plugin::syslog`

```puppet
class { 'collectd::plugin::syslog':
  log_level => 'warning'
}
```

####Class: `collectd::plugin::tcpconns`

```puppet
class { 'collectd::plugin::tcpconns':
  localports  => ['25', '12026'],
  remoteports => ['25'],
  listening   => false,
}
```
####Class: `collectd::plugin::tail`

```puppet
collectd::plugin::tail::file { 'exim-log':
  filename => '/var/log/exim4/mainlog',
  instance => 'exim',
  matches  => [
    {
      regex    => 'S=([1-9][0-9]*)',
      dstype   => 'CounterAdd',
      type     => 'ipt_bytes',
      instance => 'total',
    },
    {
      regex    => '\\<R=local_user\\>',
      dstype   => 'CounterInc',
      type     => 'counter',
      instance => 'local_user',
    }
  ]
}
```

####Class: `collectd::plugin::unixsock`

```puppet
class {'collectd::plugin::unixsock':
  socketfile   => '/var/run/collectd-sock',
  socketgroup  => 'nagios',
  socketperms  => '0770',
  deletesocket => false,
}
```

####Class: `collectd::plugin::uptime`

```puppet
class {'collectd::plugin::uptime':
}
```

####Class: `collectd::plugin::users`
```puppet
class {'collectd::plugin::users':
}
```

####Class: `collectd::plugin::varnish`

```puppet
class { 'collectd::plugin::varnish':
  instances => {
    'instanceName' => {
      'CollectCache' => 'true',
      'CollectBackend' => 'true',
      'CollectConnections' => 'true',
      'CollectSHM' => 'true',
      'CollectESI' => 'false',
      'CollectFetch' => 'true',
      'CollectHCB' => 'false',
      'CollectTotals' => 'true',
      'CollectWorkers' => 'true',
    }
  },
}
```

####Class: `collectd::plugin::vmem`

```puppet
class { 'collectd::plugin::vmem':
  verbose => true,
}
```

####Class: `collectd::plugin::write_graphite`

```puppet
class { 'collectd::plugin::write_graphite':
  graphitehost => 'graphite.examle.org',
}
```

####Class: `collectd::plugin::write_http`

```puppet
class { 'collectd::plugin::write_http':
  urls => {
    'collect1.example.org' => { 'format' => 'JSON' },
    'collect2.example.org' => {},
  }
}
```

####Class: `collectd::plugin::write_network`

**Deprecated**

```puppet
class { 'collectd::plugin::write_network':
  servers => {
    'collect1.example.org' => { 'serverport' => '25826' },
    'collect2.example.org' => { 'serverport' => '25826' }
  }
}
```

####Class: `collectd::plugin::write_riemann`

```puppet
class { 'collectd::plugin::write_riemann':
  riemann_host => 'riemann.example.org',
  riemann_port => 5555,
}
```

##Limitations

See metadata.json for supported platforms

##Development

### Running tests

This project contains tests for [rspec-puppet](http://rspec-puppet.com/).

Quickstart:

```bash
gem install bundler
bundle install
bundle exec rake lint
bundle exec rake validate
bundle exec rake spec SPEC_OPTS='--format documentation'
```
