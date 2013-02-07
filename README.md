Collectd module for Puppet
==========================

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

    include collectd

Collectd is most useful when configured with customized plugins.
This is accomplished by removing the default collectd.conf file
and replacing it with a file that includes all alternative
configurations. Configure a node with the following class
declaration:

    class { '::collectd':
      purge        => true,
      recurse      => true,
      purge_config => true,
    }

Set purge, recurse, and purge_config to true in order to override
the default configurations shipped in collectd.conf and use
custom configurations stored in conf.d. From here you can set up
additional plugins as shown below.

Simple Plugins
--------------

Example of how to load plugins with no additional configuration:

    collectd::plugin { 'battery': }

where 'battery' is the name of the plugin.

Additional Plugins
------------------

Some non-default plugins are shipped with this module. Configure
these plugins with, for example

    class { 'collectd::plugin::df':
      mountpoints    => ['/u'],
      fstypes        => ['nfs','tmpfs','autofs','gpfs','proc','devpts'],
      ignoreselected => 'true',
    }

Parameters will vary widely between plugins. See the collectd
documentation for each plugin for configurable attributes.
