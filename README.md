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

* `apache`  (see [collectd::plugin::apache](#class-collectdpluginapache) below)
* `bind`
* `df`  (see [collectd::plugin::df](#class-collectdplugindf) below)
* `disk` (see [collectd::plugin::disk](#class-collectdplugindisk) below)
* `filecount` (see [collectd::plugin::filecount](#class-collectdpluginfilecount) below)
* `interface`
* `iptables`
* `irq`
* `memcached`(see [collectd::plugin::memcached](#class-collectdpluginmemcached) below )
* `mysql` (see [collectd::plugin::mysql](#class-collectdpluginmysql) below)
* `network`
* `nginx`
* `ntpd` (see [collectd::plugin::ntpd](#class-collectdpluginntpd) below)
* `openvpn` (see [collectd::plugin::openvpn](#class-collectdpluginopenvpn) below)
* `snmp` (see [collectd::plugin::snmp](#class-collectdpluginsnmp) below)
* `syslog` (see [collectd::plugin::sylog](#class-collectdpluginsylog) below)
* `tcpconns` (see [collectd::plugin::tcpconns](#class-collectdplugintcpconns) below)
* `unixsock` (see [collectd::plugin::unixsock](#class-collectdpluginunixsock) below)
* `write_graphite` (see [collectd::plugin::write_graphite](#class-collectdpluginwrite_graphite) below)

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

####Class: `collectd::plugin::df`

```puppet
class { 'collectd::plugin::df':
  mountpoints    => ['/u'],
  fstypes        => ['nfs','tmpfs','autofs','gpfs','proc','devpts'],
  ignoreselected => 'true',
}
```

####Class: `collectd::plugin::disk`

```puppet
class { 'collectd::plugin::disk':
  disks          => ['/^dm/'],
  ignoreselected => 'true'
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

####Class: `collectd::plugin::memcached`

```puppet
class { 'collectd::plugin::memcached':
  host => '192.168.122.1',
  port => '11211',
}
```

####Class: `collectd::plugin::mysql`

```puppet
class { 'collectd::plugin::mysql':
  database  => 'betadase',
  host      => 'localhost',
  username  => 'stahmna',
  password  => 'secret',
  port      => '3306',
}
```

####Class: `collectd::plugin::ntpd`

```puppet
class { 'collectd::plugin::ntpd':
  host           => 'localhost',
  port           => '123',
  reverselookups => 'false',
  includeunitid  => 'false',
}
```

####Class: `collectd::plugin::openvpn`

```puppet
class { 'collectd::plugin::openvpn':
  collectindividualusers => 'false',
  collectusercount       => 'true',
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

####Class: `collectd::plugin::unixsock`

```puppet
class {'collectd::plugin::unixsock':
  socketfile  => '/var/run/collectd-sock',
  socketgroup => 'nagios',
}

```
####Class: `collectd::plugin::write_graphite`

```puppet
class { 'collectd::plugin::write_graphite':
  graphitehost => 'graphite.examle.org',
}
```

##Limitations

This module has been tested on Ubuntu Precise, CentOS 5/6, Solaris 10, and Debian 6/7.

##Development

### Running tests

This project contains tests for both [rspec-puppet](http://rspec-puppet.com/) and [rspec-system](https://github.com/puppetlabs/rspec-system) to verify functionality. For in-depth information please see their respective documentation.

Quickstart:

    gem install bundler
    bundle install
    bundle exec rake spec
    bundle exec rake spec:system
