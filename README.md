Collectd module for Puppet
==========================

[![Build Status](https://travis-ci.org/pdxcat/puppet-module-collectd.png?branch=master)](https://travis-ci.org/pdxcat/puppet-module-collectd)

Description
-----------

Puppet module for configuring collectd and plugins.

Supported Platforms
-------------------

* Debian
* Solaris
* Redhat

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

* `bind`
* `df`  (see [collectd::plugin::df](#class-collectdplugindf) below)
* `disk` (see [collectd::plugin::disk](#class-collectdplugindisk) below)
* `interface`
* `iptables`
* `irq`
* `mysql` (see [collectd::plugin::mysql](#class-collectdpluginmysql) below)
* `network`
* `nginx`
* `openvpn` (see [collectd::plugin::openvpn](#class-collectdpluginopenvpn) below)
* `syslog` (see [collectd::plugin::sylog](#class-collectdpluginsylog) below)
* `write_graphite` (see [collectd::plugin::write_graphite](#class-collectdpluginwrite_graphite) below)

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

####Class: `collectd::plugin::openvpn`

```puppet
class { 'collectd::plugin::openvpn':
  collectindividualusers => 'false',
  collectusercount       => 'true',
}
```

####Class: `collectd::plugin::syslog`

```puppet
class { 'collectd::plugin::syslog':
  log_level => 'warning'
}
```

####Class: `collectd::plugin::write_graphite`

```puppet
class { 'collectd::plugin::write_graphite':
  graphitehost => 'graphite.examle.org',
}
```
