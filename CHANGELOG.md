## 2014-10-04 Release 3.0.1

### Backwards-incompatible changes:

none

### Summary:

Bug fix release

### Features:

* Add support for manually specifying the hostname

### Bugs:

* Add dependency for python plugins
* Set default value of chains to be hash
* Sort snmp data and hosts hash

## 2014-08-25 Release 3.0.0

### Backwards-incompatible changes:

* Make sure plugin_conf_dir is not world readable
* Full rewrite of the network plugin
* Rewrite of postgresql module to allow invocation by defined types

### Summary:

This release adds multiple new plugins and improvements

### Features:

* Varnish plugin improvments
* Add the ability to customize package name.
* Add write_http plugin
* Add statsd plugin
* Add plugin logfile
* Add curl plugin
* Add support for sensors plugin
* Add support for perl plugins
* Allow custom Include directives
* Add valuesabsolute and valuespercentage to df plugin

### Bugs:

* Issue 164: syslog plugin needs to be loaded as first plugin
* notify the collectd service when purging plugins
* add collectd-rrdtool package needed for RedHat
* sort python.conf options hash

## 2014-04-14 Release 2.1.0

### Summary:

This release adds Gentoo osfamily support and minor plugin changes

### Features:

- adding Gentoo support
- tcpconn plugin: $localports and $remoteports can me left undef if $listening is not set
- unixsock plugin: Implement the "DeleteSocket" option.
- add reportreserved parameter for df plugin


## 2014-04-14 Release 2.0.1

### Summary:

Fix issue with metadata.json preventing Forge uploads

## 2014-04-14 Release 2.0.0

### Summary:

This release adds support for several new plugins and contains
some backwards-incompatible code refactors.

### Backwards-incompatible changes:

- Storerates=true is now the default for the Graphite plugin
- Deprecate write_network plugin, use network plugin instead
- Make sure plugin configs are not world readable.
- Handle plugin order with collectd::plugin resource type
  (all collectd plugins config files will be renumbered from
   00-$name.conf to 10-$name.conf)

### Features:

- New plugins CSV, uptime, users, entropy, varnish, redis,
  contextswitch, cpu, nfs, vmem, libvirt
- Add socket parameter to mysql plugin
- Add reportbytes to swap plugin
- Add SeparateInstances setting to write_graphite plugin
- Add metadata.json for Forge search support

### Bugs:

- Fix port parameter quotes in memcached plugin
- Fix collectd conf dir path parameter assignment
- Fix processes plugin configuration
- Force ReportReserved to true in df plugin

## 2014-01-18 Release 1.1.0

### Summary:

This release adds support for new plugins and fixes multiple bugs in
several plugin configurations.

### Features:

- Added load plugin
- Added memory plugin
- Added rrdtool plugin
- Added swap plugin
- Initial version of PostgreSQL plugin
- Add protocol paramter to write_graphite plugin
- add tests for network module
- Support pre-4.7 network configs.

### Bugs:

- Fix bug that always creates notification in exec on empty params
- fix typo in apache plugin manifest
- Make sure that plugins are always loaded before their configuration
- Add version check around emitting Protocol config
- mysql: use double quotes according to version
- Allow for alphanumeric collectd version numbers
- (gh-85) Fix null versioncmp bug in plugin templates
- (gh-69) Fix package name on RedHat

## 2013-12-17 Release 1.0.2

### Summary:

This release adds the AMQP plugin and a collectd version fact.

### Features:

- Add AMQP plugin
- Add class parameter typesdb
- Use collectd::params::root_group instead of fixed group name
- Add collectd version fact

## 2013-12-04 Release 1.0.1

### Summary:

This release introduces Archlinux osfamily support and support for
three new plugins ping, rrdcached, and processes.

### Features:

 - Initial version of rrdcached plugin
 - Add configurable processes plugin
 - Add quotes for string values in network plugin
 - Add ping plugin
 - Add support for Archlinux
 - Allow to set all write_graphite options.

### Bugs:

 - Fixed missing double quotes in unixsock plugin template
 - Added comma to syntax error in bind.pp

## 2013-10-20 Release 1.0.0

### Summary:

This release breaks some backwards compatibility
on some plugins where they improperly used strings instead of
booleans parameters. This release also includes osfamily
support for SUSE and FreeBSB and support for four new plugins.

### Backwards-incompatible changes:

 - Plugins that use to accept strings now use booleans
   for a more consistent interface across the various plugins
 - The main collectd config file now only includes *.conf files
   to allow plugin specific files to be placed in the conf.d
   directory.
 - The mysql plugin now supports multiple databases via the
   collectd::plugin::mysql::database define. This change breaks
   backwards compatiblity on the mysql plugin.

### Features:

 - osfamily support for SUSE
 - osfamily support for FreeBSD
 - tail plugin
 - exec plugin
 - python plugin
 - write_riemann plugin

## 2013-09-27 Release 0.1.0

### Summary:

Add curl_json and apache plugin

### Backwards-incompatible changes:

 - The write_network plugin now accepts a hash of servers

### Features:

 - Add curl_json plugin
 - Added collectd package version parameter
 - Add apache plugin

0.0.5 - pdxcat/collectd - 2013/09/24

  6adca9a add ntpd plugin
  ab55fb4 Added tcpconns plugin and example for it in README
  677ff72 Adding a new generic write_network plugin define
  8cdd8b7 Added memcached plugin and example for it in README
  c3e4a02 Added examples to README for filecount, SNMP and unixsock
  f798c84 Added support for file count plugin
  66f7392 Added support for SNMP and bumped stdlib dependency version to 3.0.0
  7118450 Added support for unix socket plugin
  a062b11 Fixed source URL
  1b214a2 Add testing docs to README

0.0.4 - pdxcat/collectd - 2013/08/26

  9f3f0f6 Add bind plugin to readme
  f052087 Add bind plugin
  fc0c4c1 Add basic rspec-system test
  0b2ec92 Fix README formatting issues
  71dcad0 Add configurable plugins to the README
  72b9f17 Add test for file_line
  7eae468 Add buildstatus to the README
  b2cb208 Add travis.yml file
  8cc16a8 Add purge_config enabled test
  26683f0 Add spec test for collectd class
  3f30650 Add spec helper files
  0bee1d7 Add nginx plugin
  e2d558a Fix network plugin config syntax
  79d8a68 Add network plugin
  c1085d7 Merge pull request #5 from agenticarus/newer-stdlib
  88678bf Depend on newer version of stdlib
  7dd9aaa added colorz to the README
  628ed78 Added configuration for StoreRates and Port.

0.0.3 - pdxcat/collectd - 2013/05/27

  f51660f Fixed test for collectd::plugin::irq
  3019516 Added default field in selector for making syntax checkers happy.
  39859e7 Added stdlib dependency for file_line

0.0.2 - pdxcat/collectd - 2013/05/09

  185e16f Modifications for following puppetlabs style guide and add smoke tests for interface, irq and iptables
  d68275f Added interface, irq and iptables support. Untested though.
  b8312cc Added use of scope.lookupvar, allow configuration of threads and option to choose between hostname and fqdn

0.0.1 - pdxcat/collectd - 2013/02/06

  8c64104 Add interval and timeout parameters
  e48288d Add redhat support to the collectd module.
  b6e3649 Add readme, module, and license files to collectd module.
  fb6b92f Fix bug in collectd::plugin define
  4096cca Add purge_config option to collectd class
  2a2974c Add purge option to collectd class
  8acbef3 Add syslog plugin
  137c919 Add ensure option for collectd::plugin
  3406430 Fix plugins with wrong metaparams
  315af94 Add collectd::plugin define for unconfigured plugins
  c085ebc Change include plugin file to include conf.d
  171bddd Template openvpn plugin and parameterize the class
  09c4df5 Add mysql plugin to collectd.
  36f3465 Add disk plugin to collectd.
  1e27a29 Fix collectd service subscription to conf file.
  15f1ea7 Add Solaris collectd parameters
  c013e73 Add collectd df plugin support
  9cac9c4 Add collectd support.
