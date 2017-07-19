# Change log

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not impact the functionality of the module.

## [v6.0.0](https://github.com/voxpupuli/puppet-collectd/tree/v6.0.0) (2017-02-12)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v5.3.0...v6.0.0)

**Implemented enhancements:**

- Add parameter to customize location of python plugin configuration [\#638](https://github.com/voxpupuli/puppet-collectd/issues/638)
- Parametrize destination of python config [\#637](https://github.com/voxpupuli/puppet-collectd/pull/637) ([Pigueiras](https://github.com/Pigueiras))
- Stop specifying $name as the default host value [\#631](https://github.com/voxpupuli/puppet-collectd/pull/631) ([jamtur01](https://github.com/jamtur01))
- Add CounterSum support to statsd config [\#620](https://github.com/voxpupuli/puppet-collectd/pull/620) ([phss](https://github.com/phss))
- add new parameter module\_import in plugin::python::module [\#618](https://github.com/voxpupuli/puppet-collectd/pull/618) ([contargo-development](https://github.com/contargo-development))
- Added plugin oracle [\#613](https://github.com/voxpupuli/puppet-collectd/pull/613) ([jkroepke](https://github.com/jkroepke))

**Fixed bugs:**

- Remove quotes from boolean options [\#640](https://github.com/voxpupuli/puppet-collectd/pull/640) ([mirekys](https://github.com/mirekys))
- Use sort on hashes in template perl/plugin.erb [\#636](https://github.com/voxpupuli/puppet-collectd/pull/636) ([blajos](https://github.com/blajos))

**Closed issues:**

- Remove quotes from the Forward option [\#639](https://github.com/voxpupuli/puppet-collectd/issues/639)

## [v5.3.0](https://github.com/voxpupuli/puppet-collectd/tree/v5.3.0) (2017-01-13)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v5.2.0...v5.3.0)

**Fixed bugs:**

- Manipulating yaml data when formatting for use in collectd::plugin::snmp [\#580](https://github.com/voxpupuli/puppet-collectd/issues/580)
- Changed casing to be standard snake\_case for collectd::plugin::snmp [\#609](https://github.com/voxpupuli/puppet-collectd/pull/609) ([robotman321](https://github.com/robotman321))

**Closed issues:**

- collectd adds dependency to all concat resources [\#624](https://github.com/voxpupuli/puppet-collectd/issues/624)
- manifests/plugin/write\_network.pp : typo [\#593](https://github.com/voxpupuli/puppet-collectd/issues/593)
- Failed to parse template collectd/loadplugin.conf.erb: undefined method `scan' for 5.4:Float [\#587](https://github.com/voxpupuli/puppet-collectd/issues/587)
- collectd::plugin::python::module does not support multiple configs for the same module [\#581](https://github.com/voxpupuli/puppet-collectd/issues/581)
- Migrate to official apt repos [\#578](https://github.com/voxpupuli/puppet-collectd/issues/578)
- Fails to run idempotently on Ubuntu 16.04 [\#554](https://github.com/voxpupuli/puppet-collectd/issues/554)
- Support the thermal plugin [\#462](https://github.com/voxpupuli/puppet-collectd/issues/462)
- varnish plugin format - read-function of plugin `varnish/instance' failed [\#380](https://github.com/voxpupuli/puppet-collectd/issues/380)

**Merged pull requests:**

- pin puppet-yum to \< 1.0.0 [\#628](https://github.com/voxpupuli/puppet-collectd/pull/628) ([bastelfreak](https://github.com/bastelfreak))
- release 5.3.0 [\#627](https://github.com/voxpupuli/puppet-collectd/pull/627) ([bastelfreak](https://github.com/bastelfreak))
- Tag collectd's concat resources [\#625](https://github.com/voxpupuli/puppet-collectd/pull/625) ([rnelson0](https://github.com/rnelson0))
- Added base threshold plugin [\#622](https://github.com/voxpupuli/puppet-collectd/pull/622) ([jamtur01](https://github.com/jamtur01))
- Bump minimum version dependencies \(for Puppet 4\) [\#614](https://github.com/voxpupuli/puppet-collectd/pull/614) ([juniorsysadmin](https://github.com/juniorsysadmin))
- Bump puppet minimum version\_requirement to 3.8.7 [\#610](https://github.com/voxpupuli/puppet-collectd/pull/610) ([juniorsysadmin](https://github.com/juniorsysadmin))
- Fix python\_dir fact for RedHat. [\#608](https://github.com/voxpupuli/puppet-collectd/pull/608) ([thlapin](https://github.com/thlapin))
- Fix documentation for aggregation type parameter [\#606](https://github.com/voxpupuli/puppet-collectd/pull/606) ([gytisgreitai](https://github.com/gytisgreitai))
- Updates to write\_riemann [\#605](https://github.com/voxpupuli/puppet-collectd/pull/605) ([jamtur01](https://github.com/jamtur01))
- fix typo [\#602](https://github.com/voxpupuli/puppet-collectd/pull/602) ([bastelfreak](https://github.com/bastelfreak))
- Added write\_prometheus plugin [\#600](https://github.com/voxpupuli/puppet-collectd/pull/600) ([jamtur01](https://github.com/jamtur01))
- Enable acceptance tests [\#598](https://github.com/voxpupuli/puppet-collectd/pull/598) ([Yuav](https://github.com/Yuav))
- Include custom rabbitmq types [\#597](https://github.com/voxpupuli/puppet-collectd/pull/597) ([Yuav](https://github.com/Yuav))
- Adds Collectd CI Package repos [\#588](https://github.com/voxpupuli/puppet-collectd/pull/588) ([petems](https://github.com/petems))

## [v5.2.0](https://github.com/voxpupuli/puppet-collectd/tree/v5.2.0) (2016-12-05)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v5.1.0...v5.2.0)

**Implemented enhancements:**

- Fix for issue \#552 including acceptance tests [\#556](https://github.com/voxpupuli/puppet-collectd/pull/556) ([Yuav](https://github.com/Yuav))

**Closed issues:**

- RabbitMQ: Fails with pip not installed [\#575](https://github.com/voxpupuli/puppet-collectd/issues/575)
- CentOS 6/7 no package collectd [\#552](https://github.com/voxpupuli/puppet-collectd/issues/552)
- write\_kafka should support hosts array [\#539](https://github.com/voxpupuli/puppet-collectd/issues/539)
- collectd-disk does not exist [\#514](https://github.com/voxpupuli/puppet-collectd/issues/514)
- Support the UUID plugin [\#465](https://github.com/voxpupuli/puppet-collectd/issues/465)
- Support the SMART plugin [\#463](https://github.com/voxpupuli/puppet-collectd/issues/463)
- Support the hddtemp plugin [\#460](https://github.com/voxpupuli/puppet-collectd/issues/460)

**Merged pull requests:**

- release 5.2.0 [\#592](https://github.com/voxpupuli/puppet-collectd/pull/592) ([bastelfreak](https://github.com/bastelfreak))
- Fallback to empty string if Python is not installed [\#591](https://github.com/voxpupuli/puppet-collectd/pull/591) ([Yuav](https://github.com/Yuav))
- Allow multiple genericjmx mbean attribute entries [\#584](https://github.com/voxpupuli/puppet-collectd/pull/584) ([crimpy88](https://github.com/crimpy88))
- collectd::plugin::python now supports multiple configurations for sam… [\#583](https://github.com/voxpupuli/puppet-collectd/pull/583) ([kazeborja](https://github.com/kazeborja))
- Ensure ppa is applied before package is installed [\#579](https://github.com/voxpupuli/puppet-collectd/pull/579) ([Yuav](https://github.com/Yuav))
- Rabbitmq plugin fix [\#577](https://github.com/voxpupuli/puppet-collectd/pull/577) ([Yuav](https://github.com/Yuav))
- rubocop: fix RSpec/ImplicitExpect [\#574](https://github.com/voxpupuli/puppet-collectd/pull/574) ([alexjfisher](https://github.com/alexjfisher))
- Add missing badges [\#573](https://github.com/voxpupuli/puppet-collectd/pull/573) ([dhoppe](https://github.com/dhoppe))
- Add support for Interface plugin option ReportInactive [\#572](https://github.com/voxpupuli/puppet-collectd/pull/572) ([matejzero](https://github.com/matejzero))
- Add support for ReportNumCpu in CPU plugin introduced in collectd 5.6 [\#571](https://github.com/voxpupuli/puppet-collectd/pull/571) ([matejzero](https://github.com/matejzero))
- Add apt repo [\#568](https://github.com/voxpupuli/puppet-collectd/pull/568) ([Yuav](https://github.com/Yuav))
- Implement rspec-puppet-facts [\#567](https://github.com/voxpupuli/puppet-collectd/pull/567) ([bastelfreak](https://github.com/bastelfreak))
- Addition of thermal plugin [\#565](https://github.com/voxpupuli/puppet-collectd/pull/565) ([crimpy88](https://github.com/crimpy88))
- Addition of uuid plugin [\#564](https://github.com/voxpupuli/puppet-collectd/pull/564) ([crimpy88](https://github.com/crimpy88))
- Addition of write\_log plugin [\#563](https://github.com/voxpupuli/puppet-collectd/pull/563) ([crimpy88](https://github.com/crimpy88))
- Addition of hddtemp plugin [\#562](https://github.com/voxpupuli/puppet-collectd/pull/562) ([crimpy88](https://github.com/crimpy88))
- Added provider\_proxy for pip [\#561](https://github.com/voxpupuli/puppet-collectd/pull/561) ([nurriz](https://github.com/nurriz))
- Change type parameter to agg\_type. Type is a reserved word in puppet. [\#560](https://github.com/voxpupuli/puppet-collectd/pull/560) ([johnburns320](https://github.com/johnburns320))
- Added missing quote [\#557](https://github.com/voxpupuli/puppet-collectd/pull/557) ([Yuav](https://github.com/Yuav))
- Update README.md [\#555](https://github.com/voxpupuli/puppet-collectd/pull/555) ([Yuav](https://github.com/Yuav))
- Add smart plugin [\#553](https://github.com/voxpupuli/puppet-collectd/pull/553) ([crimpy88](https://github.com/crimpy88))
- Solves Issue \#550 for lvm, disk and python plugins [\#551](https://github.com/voxpupuli/puppet-collectd/pull/551) ([markasammut](https://github.com/markasammut))
- plugin/write\_kafka.pp: [\#540](https://github.com/voxpupuli/puppet-collectd/pull/540) ([devfaz](https://github.com/devfaz))
- remove write\_graphite-config.conf on absent \(fixes \#533\) [\#534](https://github.com/voxpupuli/puppet-collectd/pull/534) ([Wayneoween](https://github.com/Wayneoween))
- add ability to add files via hiera [\#532](https://github.com/voxpupuli/puppet-collectd/pull/532) ([sigsegv0x0b](https://github.com/sigsegv0x0b))
- changed ceph plugin config template to allow for non-default cluster … [\#531](https://github.com/voxpupuli/puppet-collectd/pull/531) ([lilhuang](https://github.com/lilhuang))
- Added package managing to the ceph plugin, as well as documentation a… [\#530](https://github.com/voxpupuli/puppet-collectd/pull/530) ([lilhuang](https://github.com/lilhuang))
- added 'Ignore', 'InvertMatch' blocks to snmp.conf.erb and the snmp da… [\#529](https://github.com/voxpupuli/puppet-collectd/pull/529) ([lilhuang](https://github.com/lilhuang))
- Fix for Concat lockfile issue [\#528](https://github.com/voxpupuli/puppet-collectd/pull/528) ([squarebracket](https://github.com/squarebracket))
- support for multiple instances for memcached [\#523](https://github.com/voxpupuli/puppet-collectd/pull/523) ([mmckinst](https://github.com/mmckinst))

## [v5.1.0](https://github.com/voxpupuli/puppet-collectd/tree/v5.1.0) (2016-08-18)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v5.0.0...v5.1.0)

**Fixed bugs:**

- target replace filter fix to allow identical keys with different values [\#518](https://github.com/voxpupuli/puppet-collectd/pull/518) ([gregsaram](https://github.com/gregsaram))

**Closed issues:**

- Error with python plugin not managing the collectd plugin directory [\#542](https://github.com/voxpupuli/puppet-collectd/issues/542)
- "write\_graphite::ensure: absent" not removing write\_graphite-config.conf [\#533](https://github.com/voxpupuli/puppet-collectd/issues/533)

**Merged pull requests:**

- remove trailing whitespace [\#535](https://github.com/voxpupuli/puppet-collectd/pull/535) ([bastelfreak](https://github.com/bastelfreak))
- Fix logic problem [\#526](https://github.com/voxpupuli/puppet-collectd/pull/526) ([jsfrerot](https://github.com/jsfrerot))
- add a java\_home option to javaplugin, so that libjvm will be loaded p… [\#525](https://github.com/voxpupuli/puppet-collectd/pull/525) ([BobVanB](https://github.com/BobVanB))
- Added scale plugin [\#521](https://github.com/voxpupuli/puppet-collectd/pull/521) ([Fabian1976](https://github.com/Fabian1976))
- add password parameter to redis plugin [\#519](https://github.com/voxpupuli/puppet-collectd/pull/519) ([sp-joseluis-ledesma](https://github.com/sp-joseluis-ledesma))
- Apache plugin - Remove quotes from VerifyPeer and VerifyHost [\#517](https://github.com/voxpupuli/puppet-collectd/pull/517) ([dansajner](https://github.com/dansajner))
- Add spec test for 'has\_wordexp' and validate\_bool [\#516](https://github.com/voxpupuli/puppet-collectd/pull/516) ([alexjfisher](https://github.com/alexjfisher))
- Adding has\_wordexp variable for template [\#515](https://github.com/voxpupuli/puppet-collectd/pull/515) ([markasammut](https://github.com/markasammut))
- Check $manage\_package if not undef [\#513](https://github.com/voxpupuli/puppet-collectd/pull/513) ([jkroepke](https://github.com/jkroepke))

## [v5.0.0](https://github.com/voxpupuli/puppet-collectd/tree/v5.0.0) (2016-05-26)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v4.3.0...v5.0.0)

**Fixed bugs:**

- Process and processmatch defines failing [\#413](https://github.com/voxpupuli/puppet-collectd/issues/413)

**Closed issues:**

- The libvirt plugin should be renamed to virt [\#492](https://github.com/voxpupuli/puppet-collectd/issues/492)
- custom types.db files overwritten [\#477](https://github.com/voxpupuli/puppet-collectd/issues/477)
- Support the MD plugin [\#464](https://github.com/voxpupuli/puppet-collectd/issues/464)
- The disk plugin should manage the package on RedHat [\#457](https://github.com/voxpupuli/puppet-collectd/issues/457)
- Python plugin regression [\#456](https://github.com/voxpupuli/puppet-collectd/issues/456)
- Add the ability to customize write\_threads [\#448](https://github.com/voxpupuli/puppet-collectd/issues/448)
- Java plugin missing from plugins dir [\#445](https://github.com/voxpupuli/puppet-collectd/issues/445)
- 'Type' reserved word in Puppet3 future parser/Puppet4  [\#441](https://github.com/voxpupuli/puppet-collectd/issues/441)
- Plugin `df' did not register for value `ReportReserved'. [\#435](https://github.com/voxpupuli/puppet-collectd/issues/435)
- The python plugin appears to be broken [\#428](https://github.com/voxpupuli/puppet-collectd/issues/428)
- Python module configs should be quoted [\#425](https://github.com/voxpupuli/puppet-collectd/issues/425)
- python plugin requires config section for modules [\#424](https://github.com/voxpupuli/puppet-collectd/issues/424)
- write\_graphite plugin config not setting protocol on first run [\#421](https://github.com/voxpupuli/puppet-collectd/issues/421)
- python-config.conf fails if collectd.d directory does not exist [\#416](https://github.com/voxpupuli/puppet-collectd/issues/416)
- New tag and add to forge [\#401](https://github.com/voxpupuli/puppet-collectd/issues/401)
- Need to do two puppet runs when adding graphite modules  [\#398](https://github.com/voxpupuli/puppet-collectd/issues/398)
- @collectd\_version not work in Plugin templates [\#377](https://github.com/voxpupuli/puppet-collectd/issues/377)
- Doesn't seem to install disk plugin. [\#366](https://github.com/voxpupuli/puppet-collectd/issues/366)
- No collectd::plugin::syslog =\> Throws errors [\#337](https://github.com/voxpupuli/puppet-collectd/issues/337)
- Plugin match\_regex, target\_set, write\_tsdb missing [\#336](https://github.com/voxpupuli/puppet-collectd/issues/336)
- plugin::chain: multiple attributes with the same key [\#333](https://github.com/voxpupuli/puppet-collectd/issues/333)
- Under Debian, does not update `collectd-core` when require =\> 'latest' [\#269](https://github.com/voxpupuli/puppet-collectd/issues/269)
- Cant set root\_group [\#263](https://github.com/voxpupuli/puppet-collectd/issues/263)
- Documentation about loading simple plugins [\#238](https://github.com/voxpupuli/puppet-collectd/issues/238)
- Some errors in the code [\#235](https://github.com/voxpupuli/puppet-collectd/issues/235)
- StoreRates Parameter is missing in the amqp Plugin [\#215](https://github.com/voxpupuli/puppet-collectd/issues/215)
- Add rspec puppet tests for plugins that don't have them [\#97](https://github.com/voxpupuli/puppet-collectd/issues/97)
- Create consistent interface to plugins [\#70](https://github.com/voxpupuli/puppet-collectd/issues/70)

**Merged pull requests:**

- Add collectd::plugin::tail::file spec test [\#511](https://github.com/voxpupuli/puppet-collectd/pull/511) ([alexjfisher](https://github.com/alexjfisher))
- Documentation fix and removed blank lines from curl\_json [\#510](https://github.com/voxpupuli/puppet-collectd/pull/510) ([matejzero](https://github.com/matejzero))
- Only set ExcludeRegex when needed \(fix for \#507\) [\#509](https://github.com/voxpupuli/puppet-collectd/pull/509) ([matejzero](https://github.com/matejzero))
- Revert "Only set ExcludeRegex in config file if variable is defined" [\#508](https://github.com/voxpupuli/puppet-collectd/pull/508) ([bastelfreak](https://github.com/bastelfreak))
- Only set ExcludeRegex in config file if variable is defined [\#507](https://github.com/voxpupuli/puppet-collectd/pull/507) ([matejzero](https://github.com/matejzero))
- Fix a typo in fhcount sample [\#506](https://github.com/voxpupuli/puppet-collectd/pull/506) ([matejzero](https://github.com/matejzero))
- SNMP Plugin - Instance should be optional [\#503](https://github.com/voxpupuli/puppet-collectd/pull/503) ([Lavaburn](https://github.com/Lavaburn))
- Adds the ability to set tags and attributes for the `write\_riemann` plugin [\#502](https://github.com/voxpupuli/puppet-collectd/pull/502) ([torrancew](https://github.com/torrancew))
- Fix rabbitmq module [\#500](https://github.com/voxpupuli/puppet-collectd/pull/500) ([bilsch](https://github.com/bilsch))
- The force param is deprecated in the concat module. Remove it. [\#499](https://github.com/voxpupuli/puppet-collectd/pull/499) ([jyaworski](https://github.com/jyaworski))
- "Add link to the pdxcat github org" [\#498](https://github.com/voxpupuli/puppet-collectd/pull/498) ([nibalizer](https://github.com/nibalizer))
- "Fix a spelling mistake" [\#497](https://github.com/voxpupuli/puppet-collectd/pull/497) ([nibalizer](https://github.com/nibalizer))
- "Adding authorship/attribution information" [\#496](https://github.com/voxpupuli/puppet-collectd/pull/496) ([nibalizer](https://github.com/nibalizer))
- Add ExcludeRegex option to tail module [\#495](https://github.com/voxpupuli/puppet-collectd/pull/495) ([matejzero](https://github.com/matejzero))
- add spec tests, update README, fix template for write\_tsdb [\#494](https://github.com/voxpupuli/puppet-collectd/pull/494) ([mothbe](https://github.com/mothbe))
- Rename libvirt to virt [\#493](https://github.com/voxpupuli/puppet-collectd/pull/493) ([jyaworski](https://github.com/jyaworski))
- Adding support for the ResolveInterval option in the collectd network plugin [\#491](https://github.com/voxpupuli/puppet-collectd/pull/491) ([punycode](https://github.com/punycode))
- Require 'shellwords' in the template. Fixes \#456 [\#490](https://github.com/voxpupuli/puppet-collectd/pull/490) ([jyaworski](https://github.com/jyaworski))
- add write\_kafka support [\#489](https://github.com/voxpupuli/puppet-collectd/pull/489) ([bnied](https://github.com/bnied))
- add validation and spec tests for write\_riemann plugin class batch param [\#486](https://github.com/voxpupuli/puppet-collectd/pull/486) ([archii](https://github.com/archii))
- Add riemann plugin ttlfactor param [\#485](https://github.com/voxpupuli/puppet-collectd/pull/485) ([archii](https://github.com/archii))
- initial spec tests for write\_riemann plugin class [\#484](https://github.com/voxpupuli/puppet-collectd/pull/484) ([archii](https://github.com/archii))
- Allow to specify queries in the redis plugin. [\#481](https://github.com/voxpupuli/puppet-collectd/pull/481) ([bzed](https://github.com/bzed))
- Add options VerifyPeer, VerifyHost and CaCert to curl\_json plugin [\#480](https://github.com/voxpupuli/puppet-collectd/pull/480) ([matejzero](https://github.com/matejzero))
- add manage\_service param [\#472](https://github.com/voxpupuli/puppet-collectd/pull/472) ([archii](https://github.com/archii))
- TimerPercentile can be specified multiple times [\#469](https://github.com/voxpupuli/puppet-collectd/pull/469) ([kimor79](https://github.com/kimor79))
- Rabbitmq [\#468](https://github.com/voxpupuli/puppet-collectd/pull/468) ([bilsch](https://github.com/bilsch))
- Ensure collectd-disk exists on RedHat and collectd \>= 5.5 [\#466](https://github.com/voxpupuli/puppet-collectd/pull/466) ([jyaworski](https://github.com/jyaworski))
- add support for write\_tsdb [\#455](https://github.com/voxpupuli/puppet-collectd/pull/455) ([mothbe](https://github.com/mothbe))
- Set collectd\_version fact to empty string if collectd not installed [\#454](https://github.com/voxpupuli/puppet-collectd/pull/454) ([johanek](https://github.com/johanek))
- Add support for cgroups plugin [\#453](https://github.com/voxpupuli/puppet-collectd/pull/453) ([jyaworski](https://github.com/jyaworski))
- Add support for ipmi plugin [\#452](https://github.com/voxpupuli/puppet-collectd/pull/452) ([jyaworski](https://github.com/jyaworski))
- ReportsReserved only exists in the df plugin before 5.5. Fixes \#435 [\#451](https://github.com/voxpupuli/puppet-collectd/pull/451) ([jyaworski](https://github.com/jyaworski))
- Add support for writethreads. Fixes \#448 [\#450](https://github.com/voxpupuli/puppet-collectd/pull/450) ([jyaworski](https://github.com/jyaworski))
- DNS needs to be package\_name, not name [\#447](https://github.com/voxpupuli/puppet-collectd/pull/447) ([jyaworski](https://github.com/jyaworski))
- Manage all the plugins that have external packages [\#446](https://github.com/voxpupuli/puppet-collectd/pull/446) ([jyaworski](https://github.com/jyaworski))
- Add GraphiteSeparateInstances and GraphiteAlwaysAppendDS to amqp plugin [\#444](https://github.com/voxpupuli/puppet-collectd/pull/444) ([jpoittevin](https://github.com/jpoittevin))
- Purge python configs fully if purge is set [\#443](https://github.com/voxpupuli/puppet-collectd/pull/443) ([jyaworski](https://github.com/jyaworski))
- Change 'type' to 'mbean\_type' in genericjmx plugin. Fixes \#441 [\#442](https://github.com/voxpupuli/puppet-collectd/pull/442) ([jyaworski](https://github.com/jyaworski))
- The StartTLS option for the openldap plugin expects a boolean instead of a string. [\#439](https://github.com/voxpupuli/puppet-collectd/pull/439) ([huasome](https://github.com/huasome))
- add optional header param for collectd::plugin::curl\_json [\#436](https://github.com/voxpupuli/puppet-collectd/pull/436) ([TheMeier](https://github.com/TheMeier))
- Plugin options do not use equals signs when assigning values [\#434](https://github.com/voxpupuli/puppet-collectd/pull/434) ([cqwense](https://github.com/cqwense))
- have configurable load plugin use template standard [\#433](https://github.com/voxpupuli/puppet-collectd/pull/433) ([cqwense](https://github.com/cqwense))
- Feature/java plugin loadmodule support [\#432](https://github.com/voxpupuli/puppet-collectd/pull/432) ([cqwense](https://github.com/cqwense))
- Feature/add fhcount plugin support [\#431](https://github.com/voxpupuli/puppet-collectd/pull/431) ([cqwense](https://github.com/cqwense))
- Manage the collectd-python package [\#429](https://github.com/voxpupuli/puppet-collectd/pull/429) ([jyaworski](https://github.com/jyaworski))
- Quote python module blocks. Fixes \#425 [\#427](https://github.com/voxpupuli/puppet-collectd/pull/427) ([jyaworski](https://github.com/jyaworski))
- Set python module config default to be an empty hash. Fixes \#424 [\#426](https://github.com/voxpupuli/puppet-collectd/pull/426) ([jyaworski](https://github.com/jyaworski))
- OpenBSD Support [\#422](https://github.com/voxpupuli/puppet-collectd/pull/422) ([xaque208](https://github.com/xaque208))
- Pin rake to avoid rubocop/rake 11 incompatibility [\#420](https://github.com/voxpupuli/puppet-collectd/pull/420) ([roidelapluie](https://github.com/roidelapluie))
- Concat 2.0 has deprecated the ensure parameter [\#419](https://github.com/voxpupuli/puppet-collectd/pull/419) ([jyaworski](https://github.com/jyaworski))
- Ensure plugin\_conf\_dir to be present [\#417](https://github.com/voxpupuli/puppet-collectd/pull/417) ([breml](https://github.com/breml))
- Adds report\_relative parameter [\#415](https://github.com/voxpupuli/puppet-collectd/pull/415) ([petems](https://github.com/petems))
- Adds ability to set config content explicitly [\#414](https://github.com/voxpupuli/puppet-collectd/pull/414) ([petems](https://github.com/petems))
- Collectd\_version\_real and setting minimum version [\#412](https://github.com/voxpupuli/puppet-collectd/pull/412) ([jyaworski](https://github.com/jyaworski))
- split out apache instance into define [\#411](https://github.com/voxpupuli/puppet-collectd/pull/411) ([ortegaga](https://github.com/ortegaga))
- Fixes issue with strict variables [\#410](https://github.com/voxpupuli/puppet-collectd/pull/410) ([petems](https://github.com/petems))
- Feature/curl json enhance [\#409](https://github.com/voxpupuli/puppet-collectd/pull/409) ([ortegaga](https://github.com/ortegaga))
- Add parameter Batch to write\_riemann plugin [\#408](https://github.com/voxpupuli/puppet-collectd/pull/408) ([archii](https://github.com/archii))
- Add parameter StoreRates to amqp plugin [\#407](https://github.com/voxpupuli/puppet-collectd/pull/407) ([dhoppe](https://github.com/dhoppe))
- Fixes GH-269 [\#406](https://github.com/voxpupuli/puppet-collectd/pull/406) ([jyaworski](https://github.com/jyaworski))
- Fixes GH-238 [\#405](https://github.com/voxpupuli/puppet-collectd/pull/405) ([jyaworski](https://github.com/jyaworski))
- fix typo in write\_sensu class example [\#404](https://github.com/voxpupuli/puppet-collectd/pull/404) ([archii](https://github.com/archii))
- Add support for puppetlabs-concat 2.x [\#403](https://github.com/voxpupuli/puppet-collectd/pull/403) ([brandonweeks](https://github.com/brandonweeks))

## [v4.3.0](https://github.com/voxpupuli/puppet-collectd/tree/v4.3.0) (2016-02-01)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v4.2.0...v4.3.0)

**Fixed bugs:**

- MySQL master/slave stats [\#355](https://github.com/voxpupuli/puppet-collectd/issues/355)

**Closed issues:**

- collectd::plugin::python::module does not support complex config [\#390](https://github.com/voxpupuli/puppet-collectd/issues/390)
- use own plugin [\#354](https://github.com/voxpupuli/puppet-collectd/issues/354)
- Wrong example for types.db [\#339](https://github.com/voxpupuli/puppet-collectd/issues/339)
- Problem with curl\_json Template [\#334](https://github.com/voxpupuli/puppet-collectd/issues/334)
- ValuesPercentage param in df plugin not reporting data unless FSType rootfs is ignored [\#330](https://github.com/voxpupuli/puppet-collectd/issues/330)
- Yo-yo effect using genericjmx [\#274](https://github.com/voxpupuli/puppet-collectd/issues/274)
- Collectd network plugin requires two puppet runs [\#162](https://github.com/voxpupuli/puppet-collectd/issues/162)

**Merged pull requests:**

- Update module to version 4.3.0 [\#402](https://github.com/voxpupuli/puppet-collectd/pull/402) ([dhoppe](https://github.com/dhoppe))
- Fixes mongodb plugin params docs to be consistent [\#397](https://github.com/voxpupuli/puppet-collectd/pull/397) ([petems](https://github.com/petems))
- Fixing bug with rename collectd::params::package variable [\#396](https://github.com/voxpupuli/puppet-collectd/pull/396) ([mmogylenko](https://github.com/mmogylenko))
- Support for ethstat plugin [\#395](https://github.com/voxpupuli/puppet-collectd/pull/395) ([gringus](https://github.com/gringus))
- Go back to collectd\_version [\#393](https://github.com/voxpupuli/puppet-collectd/pull/393) ([jyaworski](https://github.com/jyaworski))
- Make module.conf.erb support complex config [\#391](https://github.com/voxpupuli/puppet-collectd/pull/391) ([elemoine](https://github.com/elemoine))
- "Use install\_helper correctly" [\#386](https://github.com/voxpupuli/puppet-collectd/pull/386) ([nibalizer](https://github.com/nibalizer))
- Allow changing of the file mode of the collectd plugin directory and custom typesdb files [\#384](https://github.com/voxpupuli/puppet-collectd/pull/384) ([lukebigum](https://github.com/lukebigum))
- Fix empty Database-names in dbi-plugin [\#382](https://github.com/voxpupuli/puppet-collectd/pull/382) ([fibbers](https://github.com/fibbers))
- Add support for openldap plugin [\#381](https://github.com/voxpupuli/puppet-collectd/pull/381) ([ortegaga](https://github.com/ortegaga))
- "Use an non beaker macro to install puppet" [\#379](https://github.com/voxpupuli/puppet-collectd/pull/379) ([nibalizer](https://github.com/nibalizer))
- Fix typo. [\#378](https://github.com/voxpupuli/puppet-collectd/pull/378) ([cstroe](https://github.com/cstroe))
- fix collectd\_real\_version regex [\#376](https://github.com/voxpupuli/puppet-collectd/pull/376) ([azhurbilo](https://github.com/azhurbilo))
- Contain sub classes so `manage\_package = false` works [\#375](https://github.com/voxpupuli/puppet-collectd/pull/375) ([caldwell](https://github.com/caldwell))
- Add mongodb plugin [\#372](https://github.com/voxpupuli/puppet-collectd/pull/372) ([ghoneycutt](https://github.com/ghoneycutt))
- plugin/ping: Transition from defined type to class [\#370](https://github.com/voxpupuli/puppet-collectd/pull/370) ([daenney](https://github.com/daenney))
- fix $manage\_package param [\#369](https://github.com/voxpupuli/puppet-collectd/pull/369) ([bastelfreak](https://github.com/bastelfreak))
- removed group naming from regex for compatibility with ruby 1.8.7 [\#368](https://github.com/voxpupuli/puppet-collectd/pull/368) ([hdoedens](https://github.com/hdoedens))
- \#355 Removed Master/Slave if statement [\#365](https://github.com/voxpupuli/puppet-collectd/pull/365) ([blacktoko](https://github.com/blacktoko))
- collectd may fail to start in wheezy if processes-plugin is used ... [\#364](https://github.com/voxpupuli/puppet-collectd/pull/364) ([devfaz](https://github.com/devfaz))
- collectd \< 5.5 doesn't come with mysql InnodbStats. [\#362](https://github.com/voxpupuli/puppet-collectd/pull/362) ([bzed](https://github.com/bzed))
- \[filecount\] do not an emit empty \<Plugin\> block [\#361](https://github.com/voxpupuli/puppet-collectd/pull/361) ([t-8ch](https://github.com/t-8ch))
- Solaris variables [\#360](https://github.com/voxpupuli/puppet-collectd/pull/360) ([t-8ch](https://github.com/t-8ch))
- Package install options [\#357](https://github.com/voxpupuli/puppet-collectd/pull/357) ([ghoneycutt](https://github.com/ghoneycutt))
- Add dns plugin [\#356](https://github.com/voxpupuli/puppet-collectd/pull/356) ([ghoneycutt](https://github.com/ghoneycutt))
- move password into .sync.yml [\#348](https://github.com/voxpupuli/puppet-collectd/pull/348) ([igalic](https://github.com/igalic))
- use the correct collectd\_version in templates [\#347](https://github.com/voxpupuli/puppet-collectd/pull/347) ([igalic](https://github.com/igalic))
- Fixing duplicate param and some housekeeping [\#345](https://github.com/voxpupuli/puppet-collectd/pull/345) ([danzilio](https://github.com/danzilio))
- fix class tests [\#344](https://github.com/voxpupuli/puppet-collectd/pull/344) ([igalic](https://github.com/igalic))
- idempotence: make output deterministic in curl\_json [\#342](https://github.com/voxpupuli/puppet-collectd/pull/342) ([igalic](https://github.com/igalic))
- Make the management of the collectd package optional [\#341](https://github.com/voxpupuli/puppet-collectd/pull/341) ([jovandeginste](https://github.com/jovandeginste))
- SNMP template typo fix s/Shitf/Shift/ [\#338](https://github.com/voxpupuli/puppet-collectd/pull/338) ([shanemadden](https://github.com/shanemadden))
- Added plugin write\_sensu [\#335](https://github.com/voxpupuli/puppet-collectd/pull/335) ([waldosCH](https://github.com/waldosCH))
- Add support for CollectInternalStats [\#332](https://github.com/voxpupuli/puppet-collectd/pull/332) ([ripienaar](https://github.com/ripienaar))
- Factor our resources into classes [\#328](https://github.com/voxpupuli/puppet-collectd/pull/328) ([danzilio](https://github.com/danzilio))
- Add Plugin Filter [\#322](https://github.com/voxpupuli/puppet-collectd/pull/322) ([Project0](https://github.com/Project0))
- Add Plugin DBI [\#319](https://github.com/voxpupuli/puppet-collectd/pull/319) ([Project0](https://github.com/Project0))

## [v4.2.0](https://github.com/voxpupuli/puppet-collectd/tree/v4.2.0) (2015-09-04)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v4.1.2...v4.2.0)

**Closed issues:**

- collectd::plugin::python doesn't add a new lines between multiple key / value in the config section [\#325](https://github.com/voxpupuli/puppet-collectd/issues/325)
- Cannot set PrintSeverity with collectd::plugin::logfile [\#317](https://github.com/voxpupuli/puppet-collectd/issues/317)

**Merged pull requests:**

- Release 4.2.0 [\#331](https://github.com/voxpupuli/puppet-collectd/pull/331) ([blkperl](https://github.com/blkperl))
- Added plugin::netlink [\#329](https://github.com/voxpupuli/puppet-collectd/pull/329) ([ttarczynski](https://github.com/ttarczynski))
- Add support for the new AllPortsSummary option. [\#327](https://github.com/voxpupuli/puppet-collectd/pull/327) ([dfilion](https://github.com/dfilion))
- Add innodbstats and slavenotifications for mysql [\#324](https://github.com/voxpupuli/puppet-collectd/pull/324) ([t-8ch](https://github.com/t-8ch))
- Typesdb [\#323](https://github.com/voxpupuli/puppet-collectd/pull/323) ([t-8ch](https://github.com/t-8ch))
- Enhance and fix snmp plugin [\#321](https://github.com/voxpupuli/puppet-collectd/pull/321) ([ortegaga](https://github.com/ortegaga))
- Small fix in documentation. [\#320](https://github.com/voxpupuli/puppet-collectd/pull/320) ([ttarczynski](https://github.com/ttarczynski))
- Add support for PrintSeverity option \(fix \#317\) [\#318](https://github.com/voxpupuli/puppet-collectd/pull/318) ([simonpasquier](https://github.com/simonpasquier))
- add collectd::plugin::ceph [\#316](https://github.com/voxpupuli/puppet-collectd/pull/316) ([TheMeier](https://github.com/TheMeier))
- Exec plugin can also be used with a parameterized class. [\#315](https://github.com/voxpupuli/puppet-collectd/pull/315) ([matejzero](https://github.com/matejzero))
- Typo: changed colon to =\>, since colon generates error [\#312](https://github.com/voxpupuli/puppet-collectd/pull/312) ([matejzero](https://github.com/matejzero))

## [v4.1.2](https://github.com/voxpupuli/puppet-collectd/tree/v4.1.2) (2015-08-06)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v4.1.0...v4.1.2)

**Merged pull requests:**

- "Release 4.1.2" [\#310](https://github.com/voxpupuli/puppet-collectd/pull/310) ([nibalizer](https://github.com/nibalizer))
- Release 4.1.1 [\#309](https://github.com/voxpupuli/puppet-collectd/pull/309) ([blkperl](https://github.com/blkperl))

## [v4.1.0](https://github.com/voxpupuli/puppet-collectd/tree/v4.1.0) (2015-08-06)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v4.1.1...v4.1.0)

## [v4.1.1](https://github.com/voxpupuli/puppet-collectd/tree/v4.1.1) (2015-08-06)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v4.0.0...v4.1.1)

**Closed issues:**

- Support new disk plugin attribute 'UdevNameAttr' [\#300](https://github.com/voxpupuli/puppet-collectd/issues/300)
- Move puppet-module-collectd to puppet-community [\#293](https://github.com/voxpupuli/puppet-collectd/issues/293)
- Support multiple graphite backends [\#261](https://github.com/voxpupuli/puppet-collectd/issues/261)
- Support puppet 4 [\#257](https://github.com/voxpupuli/puppet-collectd/issues/257)
- iptables module needs to support multiple chains by same name [\#237](https://github.com/voxpupuli/puppet-collectd/issues/237)
- Cannot configure multiple "Import" modules with Python plugin [\#227](https://github.com/voxpupuli/puppet-collectd/issues/227)

**Merged pull requests:**

- Release 4.1.0 [\#308](https://github.com/voxpupuli/puppet-collectd/pull/308) ([blkperl](https://github.com/blkperl))
- Fix rspec deprecation warnings [\#307](https://github.com/voxpupuli/puppet-collectd/pull/307) ([blkperl](https://github.com/blkperl))
- GH-293: Move to puppet community github org [\#306](https://github.com/voxpupuli/puppet-collectd/pull/306) ([blkperl](https://github.com/blkperl))
- add option to not install collectd-iptables package [\#303](https://github.com/voxpupuli/puppet-collectd/pull/303) ([gibre](https://github.com/gibre))
- Allow iptables chains parameter to be an array \(fix \#237\) [\#302](https://github.com/voxpupuli/puppet-collectd/pull/302) ([jonnangle](https://github.com/jonnangle))
- Support UdevNameAttr attribute on disk plugin \(fixes \#300\) [\#301](https://github.com/voxpupuli/puppet-collectd/pull/301) ([jonnangle](https://github.com/jonnangle))

## [v4.0.0](https://github.com/voxpupuli/puppet-collectd/tree/v4.0.0) (2015-07-27)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v3.4.0...v4.0.0)

**Closed issues:**

- Using collectd::plugin::curl\_json in a define results in Puppet duplicate declaration errors [\#290](https://github.com/voxpupuli/puppet-collectd/issues/290)
- df plugin doesn't support ValuesPercentage [\#288](https://github.com/voxpupuli/puppet-collectd/issues/288)
- Support multiple exec statements [\#286](https://github.com/voxpupuli/puppet-collectd/issues/286)
- Wrong format in python plugin configuration [\#281](https://github.com/voxpupuli/puppet-collectd/issues/281)
- Allow ensure =\> absent [\#271](https://github.com/voxpupuli/puppet-collectd/issues/271)
- collectd-write\_http package doesn't always exist for RedHat derivatives [\#251](https://github.com/voxpupuli/puppet-collectd/issues/251)

**Merged pull requests:**

- Release 4.0.0 [\#298](https://github.com/voxpupuli/puppet-collectd/pull/298) ([blkperl](https://github.com/blkperl))
- adding ValuesAbsolute and ValuesPercentage to memory and swap [\#297](https://github.com/voxpupuli/puppet-collectd/pull/297) ([ChrisHeerschap](https://github.com/ChrisHeerschap))
- Add carbon default values as parameter to create\_resources [\#296](https://github.com/voxpupuli/puppet-collectd/pull/296) ([jyaworski](https://github.com/jyaworski))
- Begin adding support for multiple openvpn 'statusfile' parameters [\#295](https://github.com/voxpupuli/puppet-collectd/pull/295) ([tbielawa](https://github.com/tbielawa))
- add support for aggregation plugin and chains [\#289](https://github.com/voxpupuli/puppet-collectd/pull/289) ([kurpipio](https://github.com/kurpipio))
- support definition of multiple exec commands [\#287](https://github.com/voxpupuli/puppet-collectd/pull/287) ([deric](https://github.com/deric))
- fix multiple instances for curl\_json [\#285](https://github.com/voxpupuli/puppet-collectd/pull/285) ([d3cker](https://github.com/d3cker))
- Fix formatting in python plugin template [\#282](https://github.com/voxpupuli/puppet-collectd/pull/282) ([ttarczynski](https://github.com/ttarczynski))
- fix cpu config parsing [\#280](https://github.com/voxpupuli/puppet-collectd/pull/280) ([bzed](https://github.com/bzed))
- add support for protocols plugin [\#279](https://github.com/voxpupuli/puppet-collectd/pull/279) ([throck](https://github.com/throck))
- Use concat to define the process plugin config. [\#278](https://github.com/voxpupuli/puppet-collectd/pull/278) ([bzed](https://github.com/bzed))
- Release 3.4.0 [\#277](https://github.com/voxpupuli/puppet-collectd/pull/277) ([blkperl](https://github.com/blkperl))
- Support multiple carbon backends [\#262](https://github.com/voxpupuli/puppet-collectd/pull/262) ([deric](https://github.com/deric))
- Fix collectd::plugin::write\_http for RedHat [\#252](https://github.com/voxpupuli/puppet-collectd/pull/252) ([simonpasquier](https://github.com/simonpasquier))

## [v3.4.0](https://github.com/voxpupuli/puppet-collectd/tree/v3.4.0) (2015-06-17)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v3.3.0...v3.4.0)

**Closed issues:**

- custom plugin install? [\#268](https://github.com/voxpupuli/puppet-collectd/issues/268)
- RHEL7 does not need the collectd-python package [\#239](https://github.com/voxpupuli/puppet-collectd/issues/239)

**Merged pull requests:**

- Add ruby 2.2.0 [\#276](https://github.com/voxpupuli/puppet-collectd/pull/276) ([blkperl](https://github.com/blkperl))
- Add puppet4 to .travis and update ruby to 2.1.6 [\#275](https://github.com/voxpupuli/puppet-collectd/pull/275) ([blkperl](https://github.com/blkperl))
- snpm/host.pp validate\_re validate on string [\#273](https://github.com/voxpupuli/puppet-collectd/pull/273) ([piotr1212](https://github.com/piotr1212))
- quote reserved word type in tail.pp so rake validate succeeds [\#272](https://github.com/voxpupuli/puppet-collectd/pull/272) ([piotr1212](https://github.com/piotr1212))
- add new cpu plugin options introduced in collectd 5.5 [\#270](https://github.com/voxpupuli/puppet-collectd/pull/270) ([piotr1212](https://github.com/piotr1212))
- Fix CollectD not being able to start due to an indentation error. [\#267](https://github.com/voxpupuli/puppet-collectd/pull/267) ([arioch](https://github.com/arioch))
- Added absent timers for statsd module. [\#260](https://github.com/voxpupuli/puppet-collectd/pull/260) ([dene14](https://github.com/dene14))
- Fix module meta data [\#259](https://github.com/voxpupuli/puppet-collectd/pull/259) ([deric](https://github.com/deric))
- Check against puppet 3.7.5 [\#258](https://github.com/voxpupuli/puppet-collectd/pull/258) ([txaj](https://github.com/txaj))
- multiple Python modules support [\#255](https://github.com/voxpupuli/puppet-collectd/pull/255) ([deric](https://github.com/deric))

## [v3.3.0](https://github.com/voxpupuli/puppet-collectd/tree/v3.3.0) (2015-04-23)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v3.2.0...v3.3.0)

**Closed issues:**

- write-graphite module: Invalid configuration option: LogSendErrors [\#253](https://github.com/voxpupuli/puppet-collectd/issues/253)
- Setting FQDNLookup to false has no effect on CentOS [\#240](https://github.com/voxpupuli/puppet-collectd/issues/240)

**Merged pull requests:**

- Fix tests [\#256](https://github.com/voxpupuli/puppet-collectd/pull/256) ([txaj](https://github.com/txaj))
- Release 3.3.0 [\#254](https://github.com/voxpupuli/puppet-collectd/pull/254) ([blkperl](https://github.com/blkperl))
- Fix permission on the MySQL plugin file [\#250](https://github.com/voxpupuli/puppet-collectd/pull/250) ([simonpasquier](https://github.com/simonpasquier))
- Fix Rakefile to enforce failure on warnings [\#248](https://github.com/voxpupuli/puppet-collectd/pull/248) ([blkperl](https://github.com/blkperl))
- CreateFiles/CreateFilesAsync expect boolean values [\#247](https://github.com/voxpupuli/puppet-collectd/pull/247) ([TheMeier](https://github.com/TheMeier))
- Only set LogSendErrors option if collectd version \>= 5.4. [\#245](https://github.com/voxpupuli/puppet-collectd/pull/245) ([danielspang](https://github.com/danielspang))
- Ruby 1.8.7 is deprecated [\#244](https://github.com/voxpupuli/puppet-collectd/pull/244) ([arioch](https://github.com/arioch))
- Package collectd-python is no longer available in EPEL [\#243](https://github.com/voxpupuli/puppet-collectd/pull/243) ([arioch](https://github.com/arioch))
- Add a section to explain version scoping & known issue for \#162 [\#242](https://github.com/voxpupuli/puppet-collectd/pull/242) ([txaj](https://github.com/txaj))
- allow to disable forwarding in network::server [\#241](https://github.com/voxpupuli/puppet-collectd/pull/241) ([devfaz](https://github.com/devfaz))

## [v3.2.0](https://github.com/voxpupuli/puppet-collectd/tree/v3.2.0) (2015-01-24)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v3.1.0...v3.2.0)

**Closed issues:**

- PE compatibility [\#231](https://github.com/voxpupuli/puppet-collectd/issues/231)
- Dependency cycle with collectd-ping [\#225](https://github.com/voxpupuli/puppet-collectd/issues/225)
- MySQL plugin does not install required packages [\#148](https://github.com/voxpupuli/puppet-collectd/issues/148)

**Merged pull requests:**

- Release 3.2.0 [\#233](https://github.com/voxpupuli/puppet-collectd/pull/233) ([blkperl](https://github.com/blkperl))
- metadata update [\#232](https://github.com/voxpupuli/puppet-collectd/pull/232) ([vchepkov](https://github.com/vchepkov))
- Added v5\_upgrade Plugin: https://collectd.org/wiki/index.php/Target:v5\_u... [\#230](https://github.com/voxpupuli/puppet-collectd/pull/230) ([michakrause](https://github.com/michakrause))
- added CollectStatistics option to rrdcached plugin [\#229](https://github.com/voxpupuli/puppet-collectd/pull/229) ([michakrause](https://github.com/michakrause))
- plugin/ntpd: IncludeUnitID option only available in collectd \> 5.2 [\#228](https://github.com/voxpupuli/puppet-collectd/pull/228) ([x-way](https://github.com/x-way))
- java and genericjmx plugins [\#226](https://github.com/voxpupuli/puppet-collectd/pull/226) ([kitchen](https://github.com/kitchen))
- split out the snmp data and hosts into defines [\#224](https://github.com/voxpupuli/puppet-collectd/pull/224) ([kitchen](https://github.com/kitchen))
- Add redhat packages on plugins [\#223](https://github.com/voxpupuli/puppet-collectd/pull/223) ([sijis](https://github.com/sijis))
- arrayify the values and collects [\#222](https://github.com/voxpupuli/puppet-collectd/pull/222) ([kitchen](https://github.com/kitchen))
- added lvm plugin [\#221](https://github.com/voxpupuli/puppet-collectd/pull/221) ([sijis](https://github.com/sijis))
- Perl Plugin: changed exec in provider 'false' case: [\#216](https://github.com/voxpupuli/puppet-collectd/pull/216) ([michakrause](https://github.com/michakrause))

## [v3.1.0](https://github.com/voxpupuli/puppet-collectd/tree/v3.1.0) (2014-12-26)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v3.0.1...v3.1.0)

**Closed issues:**

- Add conntrack plugin [\#204](https://github.com/voxpupuli/puppet-collectd/issues/204)
- LIBVIRT plugin does not install required packages \[CentOS 6\] [\#184](https://github.com/voxpupuli/puppet-collectd/issues/184)
- Setting collectd::plugin::nginx params does not work for booleans [\#182](https://github.com/voxpupuli/puppet-collectd/issues/182)
- Wrong file permissions when installing from forge [\#179](https://github.com/voxpupuli/puppet-collectd/issues/179)
- Convert rspec-system tests to beaker [\#98](https://github.com/voxpupuli/puppet-collectd/issues/98)

**Merged pull requests:**

- Disable sudo in .travis.yml to enable container builds [\#220](https://github.com/voxpupuli/puppet-collectd/pull/220) ([blkperl](https://github.com/blkperl))
- Release 3.1.0 [\#219](https://github.com/voxpupuli/puppet-collectd/pull/219) ([blkperl](https://github.com/blkperl))
- exec plugin refresh [\#218](https://github.com/voxpupuli/puppet-collectd/pull/218) ([zdenekjanda](https://github.com/zdenekjanda))
- filecount: support all options [\#217](https://github.com/voxpupuli/puppet-collectd/pull/217) ([bogus-py](https://github.com/bogus-py))
- plugin::python introduce ensure parameter [\#214](https://github.com/voxpupuli/puppet-collectd/pull/214) ([bogus-py](https://github.com/bogus-py))
- Add conntrack to README.md [\#213](https://github.com/voxpupuli/puppet-collectd/pull/213) ([petems](https://github.com/petems))
- Make plugins passing the $interval parameter [\#211](https://github.com/voxpupuli/puppet-collectd/pull/211) ([txaj](https://github.com/txaj))
- Ensure variable using 'false' will be interpreted. [\#210](https://github.com/voxpupuli/puppet-collectd/pull/210) ([txaj](https://github.com/txaj))
- Add conntrack module [\#209](https://github.com/voxpupuli/puppet-collectd/pull/209) ([txaj](https://github.com/txaj))
- Fix travis by using plabs gemfile [\#208](https://github.com/voxpupuli/puppet-collectd/pull/208) ([nibalizer](https://github.com/nibalizer))
- Basic acceptance test with beaker [\#207](https://github.com/voxpupuli/puppet-collectd/pull/207) ([petems](https://github.com/petems))
- Add cpufreqplugin [\#206](https://github.com/voxpupuli/puppet-collectd/pull/206) ([muling-tt](https://github.com/muling-tt))
- Fix Puppet deprecation warning [\#205](https://github.com/voxpupuli/puppet-collectd/pull/205) ([petems](https://github.com/petems))
- Style / lintian fixes [\#202](https://github.com/voxpupuli/puppet-collectd/pull/202) ([arioch](https://github.com/arioch))
- curl: fix handling of some parameters [\#201](https://github.com/voxpupuli/puppet-collectd/pull/201) ([bogus-py](https://github.com/bogus-py))
- Uses the LoadPlugin syntax with bracket when supported [\#200](https://github.com/voxpupuli/puppet-collectd/pull/200) ([txaj](https://github.com/txaj))
- Support LogSendErrors on the write\_graphite plugin [\#199](https://github.com/voxpupuli/puppet-collectd/pull/199) ([zoni](https://github.com/zoni))
- Add collectd::plugin::zfs\_arc [\#198](https://github.com/voxpupuli/puppet-collectd/pull/198) ([zoni](https://github.com/zoni))
- Add "" to Hostname [\#197](https://github.com/voxpupuli/puppet-collectd/pull/197) ([guerremdq](https://github.com/guerremdq))
- README.md: Fixed example entropy snippet. [\#196](https://github.com/voxpupuli/puppet-collectd/pull/196) ([jpds](https://github.com/jpds))
- Double quote the csv plugin DataDir. [\#195](https://github.com/voxpupuli/puppet-collectd/pull/195) ([quiffman](https://github.com/quiffman))
- curl\_json: Support reading from a unix socket [\#193](https://github.com/voxpupuli/puppet-collectd/pull/193) ([radford](https://github.com/radford))
- write\_http: StoreRates is a bool, not a string [\#192](https://github.com/voxpupuli/puppet-collectd/pull/192) ([radford](https://github.com/radford))
- curl : 'MeasureResponseTime' needs exactly one boolean argument [\#191](https://github.com/voxpupuli/puppet-collectd/pull/191) ([bdossantos](https://github.com/bdossantos))
- Add collectd-apache package needed on RedHat [\#190](https://github.com/voxpupuli/puppet-collectd/pull/190) ([dedded](https://github.com/dedded))
- New style naming and permissions for curl\_json plugin [\#189](https://github.com/voxpupuli/puppet-collectd/pull/189) ([zdenekjanda](https://github.com/zdenekjanda))
- Ensured deprecated file removed [\#188](https://github.com/voxpupuli/puppet-collectd/pull/188) ([zdenekjanda](https://github.com/zdenekjanda))
- add a missing p [\#187](https://github.com/voxpupuli/puppet-collectd/pull/187) ([rjw1](https://github.com/rjw1))
- add missing package [\#186](https://github.com/voxpupuli/puppet-collectd/pull/186) ([czhujer](https://github.com/czhujer))
- Fix template variable to use @-notation [\#185](https://github.com/voxpupuli/puppet-collectd/pull/185) ([smoeding](https://github.com/smoeding))
- Adding support for WriteQueueLimitLow & WriteQueueLimitHigh [\#178](https://github.com/voxpupuli/puppet-collectd/pull/178) ([joshgarnett](https://github.com/joshgarnett))

## [v3.0.1](https://github.com/voxpupuli/puppet-collectd/tree/v3.0.1) (2014-10-04)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v3.0.0...v3.0.1)

**Closed issues:**

- change the way we ask collectd to reload [\#180](https://github.com/voxpupuli/puppet-collectd/issues/180)
- Module file missing? [\#175](https://github.com/voxpupuli/puppet-collectd/issues/175)

**Merged pull requests:**

- Release 3.0.1 [\#181](https://github.com/voxpupuli/puppet-collectd/pull/181) ([blkperl](https://github.com/blkperl))
- Add dependency for python plugins [\#177](https://github.com/voxpupuli/puppet-collectd/pull/177) ([bodgit](https://github.com/bodgit))
- Set default value of chains to be hash [\#176](https://github.com/voxpupuli/puppet-collectd/pull/176) ([jkinred](https://github.com/jkinred))
- Add support for manually specifying the hostname collectd uses [\#174](https://github.com/voxpupuli/puppet-collectd/pull/174) ([joshgarnett](https://github.com/joshgarnett))

## [v3.0.0](https://github.com/voxpupuli/puppet-collectd/tree/v3.0.0) (2014-08-26)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v2.1.0...v3.0.0)

**Closed issues:**

- Support types.db?  [\#172](https://github.com/voxpupuli/puppet-collectd/issues/172)
- syslog plugin needs to be loaded as first plugin [\#164](https://github.com/voxpupuli/puppet-collectd/issues/164)
- config options in python.conf.erb [\#152](https://github.com/voxpupuli/puppet-collectd/issues/152)
- python: remove script\_source [\#150](https://github.com/voxpupuli/puppet-collectd/issues/150)
- Packaging results in wrong permissions [\#91](https://github.com/voxpupuli/puppet-collectd/issues/91)

**Merged pull requests:**

- Release 3.0.0 [\#173](https://github.com/voxpupuli/puppet-collectd/pull/173) ([blkperl](https://github.com/blkperl))
- Improve collectd varnish [\#171](https://github.com/voxpupuli/puppet-collectd/pull/171) ([robyoung](https://github.com/robyoung))
- Add the possibility to customize package name. [\#170](https://github.com/voxpupuli/puppet-collectd/pull/170) ([bdossantos](https://github.com/bdossantos))
- notify the collectd service when purging plugins [\#169](https://github.com/voxpupuli/puppet-collectd/pull/169) ([kitchen](https://github.com/kitchen))
- Rewrite of postgresql module to allow invocation by defined types [\#168](https://github.com/voxpupuli/puppet-collectd/pull/168) ([txaj](https://github.com/txaj))
- add collectd-rrdtool package needed for RedHat [\#167](https://github.com/voxpupuli/puppet-collectd/pull/167) ([cfeskens](https://github.com/cfeskens))
- Issue 164: syslog plugin needs to be loaded as first plugin [\#166](https://github.com/voxpupuli/puppet-collectd/pull/166) ([txaj](https://github.com/txaj))
- Full rewrite of the network plugin [\#165](https://github.com/voxpupuli/puppet-collectd/pull/165) ([txaj](https://github.com/txaj))
- add support for sensors plugin [\#163](https://github.com/voxpupuli/puppet-collectd/pull/163) ([x-way](https://github.com/x-way))
- add support for perl plugins [\#161](https://github.com/voxpupuli/puppet-collectd/pull/161) ([faxm0dem](https://github.com/faxm0dem))
- Make sure plugin\_conf\_dir is not world readable [\#160](https://github.com/voxpupuli/puppet-collectd/pull/160) ([txaj](https://github.com/txaj))
- Allow to speficy custom Include directives [\#159](https://github.com/voxpupuli/puppet-collectd/pull/159) ([txaj](https://github.com/txaj))
- Support curl plugin [\#158](https://github.com/voxpupuli/puppet-collectd/pull/158) ([txaj](https://github.com/txaj))
- Remove rspec-system tests [\#157](https://github.com/voxpupuli/puppet-collectd/pull/157) ([blkperl](https://github.com/blkperl))
- Update travis.yml, Gemfile, and Rakefile [\#156](https://github.com/voxpupuli/puppet-collectd/pull/156) ([blkperl](https://github.com/blkperl))
- added plugin logfile [\#155](https://github.com/voxpupuli/puppet-collectd/pull/155) ([janschumann](https://github.com/janschumann))
- added sort to python.conf.erb options hash [\#153](https://github.com/voxpupuli/puppet-collectd/pull/153) ([jameseck](https://github.com/jameseck))
- Add statsd plugin config [\#149](https://github.com/voxpupuli/puppet-collectd/pull/149) ([kimor79](https://github.com/kimor79))
- Add write\_http config [\#147](https://github.com/voxpupuli/puppet-collectd/pull/147) ([kimor79](https://github.com/kimor79))

## [v2.1.0](https://github.com/voxpupuli/puppet-collectd/tree/v2.1.0) (2014-05-27)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v2.0.1...v2.1.0)

**Closed issues:**

- Small issue with tcpconns plugin [\#142](https://github.com/voxpupuli/puppet-collectd/issues/142)
- New release \(1.2.0?\) [\#133](https://github.com/voxpupuli/puppet-collectd/issues/133)
- Could not retrieve collectd\_version: undefined method `which' for Facter::Util::Resolution:Class [\#108](https://github.com/voxpupuli/puppet-collectd/issues/108)
- Install from source? [\#104](https://github.com/voxpupuli/puppet-collectd/issues/104)

**Merged pull requests:**

- Release 2.1.0 [\#146](https://github.com/voxpupuli/puppet-collectd/pull/146) ([blkperl](https://github.com/blkperl))
- adding Gentoo support [\#145](https://github.com/voxpupuli/puppet-collectd/pull/145) ([chrislovecnm](https://github.com/chrislovecnm))
- tcpconn plugin: $localports and $remoteports can me left undef [\#144](https://github.com/voxpupuli/puppet-collectd/pull/144) ([txaj](https://github.com/txaj))
- Unixsock delete option [\#140](https://github.com/voxpupuli/puppet-collectd/pull/140) ([txaj](https://github.com/txaj))
- add reportreserved parameter for df plugin [\#139](https://github.com/voxpupuli/puppet-collectd/pull/139) ([mmoll](https://github.com/mmoll))

## [v2.0.1](https://github.com/voxpupuli/puppet-collectd/tree/v2.0.1) (2014-04-14)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v2.0.0...v2.0.1)

## [v2.0.0](https://github.com/voxpupuli/puppet-collectd/tree/v2.0.0) (2014-04-14)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v1.1.0...v2.0.0)

**Closed issues:**

- write\_graphite storerates should default to collectd default [\#106](https://github.com/voxpupuli/puppet-collectd/issues/106)
- Request: Varnish plugin [\#75](https://github.com/voxpupuli/puppet-collectd/issues/75)
- redhat package name does not work with version [\#69](https://github.com/voxpupuli/puppet-collectd/issues/69)

**Merged pull requests:**

- Release 2.0.0 [\#135](https://github.com/voxpupuli/puppet-collectd/pull/135) ([blkperl](https://github.com/blkperl))
- Support libvirt plugin [\#134](https://github.com/voxpupuli/puppet-collectd/pull/134) ([ustuehler](https://github.com/ustuehler))
- Plugin config should not be world-readable [\#132](https://github.com/voxpupuli/puppet-collectd/pull/132) ([jarib](https://github.com/jarib))
- write\_graphite: support setting SeparateInstances [\#131](https://github.com/voxpupuli/puppet-collectd/pull/131) ([jarib](https://github.com/jarib))
- adding metadata.json for better forge searching [\#130](https://github.com/voxpupuli/puppet-collectd/pull/130) ([nibalizer](https://github.com/nibalizer))
- Comments [\#129](https://github.com/voxpupuli/puppet-collectd/pull/129) ([jpoittevin](https://github.com/jpoittevin))
- Style fixes [\#128](https://github.com/voxpupuli/puppet-collectd/pull/128) ([jpoittevin](https://github.com/jpoittevin))
- Add cpu plugin [\#127](https://github.com/voxpupuli/puppet-collectd/pull/127) ([jpoittevin](https://github.com/jpoittevin))
- Fix port parameter quotes in memcached plugin [\#126](https://github.com/voxpupuli/puppet-collectd/pull/126) ([jpoittevin](https://github.com/jpoittevin))
- Add vmem plugin [\#125](https://github.com/voxpupuli/puppet-collectd/pull/125) ([jpoittevin](https://github.com/jpoittevin))
- Add nfs plugin [\#124](https://github.com/voxpupuli/puppet-collectd/pull/124) ([jpoittevin](https://github.com/jpoittevin))
- Fix timeout parameter quotes in redis plugin [\#123](https://github.com/voxpupuli/puppet-collectd/pull/123) ([jpoittevin](https://github.com/jpoittevin))
- Fix typo in amqp plugin [\#122](https://github.com/voxpupuli/puppet-collectd/pull/122) ([jpoittevin](https://github.com/jpoittevin))
- Contextswitch plugin [\#120](https://github.com/voxpupuli/puppet-collectd/pull/120) ([jpoittevin](https://github.com/jpoittevin))
- Force ReportReserved to true in df plugin [\#119](https://github.com/voxpupuli/puppet-collectd/pull/119) ([jpoittevin](https://github.com/jpoittevin))
- Deprecate write\_network plugin [\#118](https://github.com/voxpupuli/puppet-collectd/pull/118) ([jpoittevin](https://github.com/jpoittevin))
- Change write\_graphite plugin storerates default [\#116](https://github.com/voxpupuli/puppet-collectd/pull/116) ([jpoittevin](https://github.com/jpoittevin))
- Varnish fixup [\#115](https://github.com/voxpupuli/puppet-collectd/pull/115) ([jpoittevin](https://github.com/jpoittevin))
- Plugins refactor [\#114](https://github.com/voxpupuli/puppet-collectd/pull/114) ([jpoittevin](https://github.com/jpoittevin))
- Fix collectd conf dir path parameter assignment [\#113](https://github.com/voxpupuli/puppet-collectd/pull/113) ([jpoittevin](https://github.com/jpoittevin))
- Fix processes plugin configuration [\#112](https://github.com/voxpupuli/puppet-collectd/pull/112) ([jpoittevin](https://github.com/jpoittevin))
- Remove reportbytes option on swap plugin [\#111](https://github.com/voxpupuli/puppet-collectd/pull/111) ([jpoittevin](https://github.com/jpoittevin))
- updated mysql plugin to include support for non-standard sockets. [\#110](https://github.com/voxpupuli/puppet-collectd/pull/110) ([thejandroman](https://github.com/thejandroman))
- Redis plugin support [\#109](https://github.com/voxpupuli/puppet-collectd/pull/109) ([paul91](https://github.com/paul91))
- Add ruby 2.1 to travis matrix [\#107](https://github.com/voxpupuli/puppet-collectd/pull/107) ([blkperl](https://github.com/blkperl))
- Added CSV plugin [\#103](https://github.com/voxpupuli/puppet-collectd/pull/103) ([Spechal](https://github.com/Spechal))
- Added entropy plugin [\#101](https://github.com/voxpupuli/puppet-collectd/pull/101) ([Spechal](https://github.com/Spechal))
- Added uptime plugin [\#100](https://github.com/voxpupuli/puppet-collectd/pull/100) ([Spechal](https://github.com/Spechal))
- Added users plugin [\#99](https://github.com/voxpupuli/puppet-collectd/pull/99) ([Spechal](https://github.com/Spechal))
- Added Varnish plugin [\#92](https://github.com/voxpupuli/puppet-collectd/pull/92) ([Spechal](https://github.com/Spechal))
- Add unit tests for alphanumeric collectd version [\#90](https://github.com/voxpupuli/puppet-collectd/pull/90) ([stepheno](https://github.com/stepheno))

## [v1.1.0](https://github.com/voxpupuli/puppet-collectd/tree/v1.1.0) (2014-01-18)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v1.0.2...v1.1.0)

**Closed issues:**

- private method `scan' called for nil:NilClass at /etc/puppet/modules/collectd/manifests/plugin/network.pp:34 [\#85](https://github.com/voxpupuli/puppet-collectd/issues/85)

**Merged pull requests:**

- Release 1.1.0 [\#89](https://github.com/voxpupuli/puppet-collectd/pull/89) ([blkperl](https://github.com/blkperl))
- \(gh-69\) Fixed package name on RedHat [\#88](https://github.com/voxpupuli/puppet-collectd/pull/88) ([cameronbwhite](https://github.com/cameronbwhite))
- \(gh-85\) Fix null versioncmp bug in plugin templates [\#87](https://github.com/voxpupuli/puppet-collectd/pull/87) ([blkperl](https://github.com/blkperl))
- Allow for alphanumeric collectd version numbers [\#86](https://github.com/voxpupuli/puppet-collectd/pull/86) ([stepheno](https://github.com/stepheno))
- Fixed missing \> in rrdtool doc ... should have been =\> [\#84](https://github.com/voxpupuli/puppet-collectd/pull/84) ([Spechal](https://github.com/Spechal))
- Added load plugin [\#83](https://github.com/voxpupuli/puppet-collectd/pull/83) ([Spechal](https://github.com/Spechal))
- Added memory plugin [\#82](https://github.com/voxpupuli/puppet-collectd/pull/82) ([Spechal](https://github.com/Spechal))
- Added rrdtool plugin [\#81](https://github.com/voxpupuli/puppet-collectd/pull/81) ([Spechal](https://github.com/Spechal))
- Added swap plugin [\#79](https://github.com/voxpupuli/puppet-collectd/pull/79) ([Spechal](https://github.com/Spechal))
- Add version check around emitting Protocol config [\#74](https://github.com/voxpupuli/puppet-collectd/pull/74) ([tombooth](https://github.com/tombooth))
- Make sure that plugins are loaded before their configuration [\#73](https://github.com/voxpupuli/puppet-collectd/pull/73) ([mmoll](https://github.com/mmoll))
- mysql: use double quotes according to version [\#72](https://github.com/voxpupuli/puppet-collectd/pull/72) ([mmoll](https://github.com/mmoll))
- fix typo in apache plugin manifest [\#71](https://github.com/voxpupuli/puppet-collectd/pull/71) ([mmoll](https://github.com/mmoll))
- Initial version of PostgreSQL plugin [\#68](https://github.com/voxpupuli/puppet-collectd/pull/68) ([smoeding](https://github.com/smoeding))
- Add protocol paramter to write\_graphite plugin [\#67](https://github.com/voxpupuli/puppet-collectd/pull/67) ([tombooth](https://github.com/tombooth))
- Fix bug that always creates notification in exec on empty params [\#65](https://github.com/voxpupuli/puppet-collectd/pull/65) ([cmurphy](https://github.com/cmurphy))
- Support pre-4.7 network configs [\#64](https://github.com/voxpupuli/puppet-collectd/pull/64) ([mmoll](https://github.com/mmoll))

## [v1.0.2](https://github.com/voxpupuli/puppet-collectd/tree/v1.0.2) (2013-12-18)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v1.0.1...v1.0.2)

**Merged pull requests:**

- Release 1.0.2 [\#63](https://github.com/voxpupuli/puppet-collectd/pull/63) ([blkperl](https://github.com/blkperl))
- Typo fix. [\#62](https://github.com/voxpupuli/puppet-collectd/pull/62) ([relsqui](https://github.com/relsqui))
- Collect fact [\#61](https://github.com/voxpupuli/puppet-collectd/pull/61) ([blkperl](https://github.com/blkperl))
- Fix puppet lint errors in proccess plugin [\#60](https://github.com/voxpupuli/puppet-collectd/pull/60) ([blkperl](https://github.com/blkperl))
- Add AMQP plugin [\#59](https://github.com/voxpupuli/puppet-collectd/pull/59) ([adrianlzt](https://github.com/adrianlzt))
- Add class parameter typesdb [\#58](https://github.com/voxpupuli/puppet-collectd/pull/58) ([smoeding](https://github.com/smoeding))
- Use collectd::params::root\_group instead of fixed group name [\#57](https://github.com/voxpupuli/puppet-collectd/pull/57) ([smoeding](https://github.com/smoeding))
- fix whitespace [\#56](https://github.com/voxpupuli/puppet-collectd/pull/56) ([mmoll](https://github.com/mmoll))

## [v1.0.1](https://github.com/voxpupuli/puppet-collectd/tree/v1.0.1) (2013-12-05)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v1.0.0...v1.0.1)

**Merged pull requests:**

- Release 1.0.1 [\#55](https://github.com/voxpupuli/puppet-collectd/pull/55) ([blkperl](https://github.com/blkperl))
- Initial version of rrdcached plugin [\#54](https://github.com/voxpupuli/puppet-collectd/pull/54) ([smoeding](https://github.com/smoeding))
- Add configurable processes plugin [\#53](https://github.com/voxpupuli/puppet-collectd/pull/53) ([tombooth](https://github.com/tombooth))
- Add quotes for string values in network plugin [\#52](https://github.com/voxpupuli/puppet-collectd/pull/52) ([smoeding](https://github.com/smoeding))
- Added collectd::plugin::ping [\#51](https://github.com/voxpupuli/puppet-collectd/pull/51) ([doismellburning](https://github.com/doismellburning))
- Add support for Archlinux [\#50](https://github.com/voxpupuli/puppet-collectd/pull/50) ([robyoung](https://github.com/robyoung))
- Added comma to syntax error in bind.pp [\#48](https://github.com/voxpupuli/puppet-collectd/pull/48) ([daniellawrence](https://github.com/daniellawrence))
- Allow to set all write\_graphite options [\#47](https://github.com/voxpupuli/puppet-collectd/pull/47) ([mmoll](https://github.com/mmoll))
- Rspec tests for few plugin classes [\#45](https://github.com/voxpupuli/puppet-collectd/pull/45) ([tripledes](https://github.com/tripledes))
- Fixed missing double quotes in unixsock plugin template [\#44](https://github.com/voxpupuli/puppet-collectd/pull/44) ([tripledes](https://github.com/tripledes))

## [v1.0.0](https://github.com/voxpupuli/puppet-collectd/tree/v1.0.0) (2013-10-20)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/v0.1.0...v1.0.0)

**Closed issues:**

- Add collectd::plugin::mysql::database define [\#33](https://github.com/voxpupuli/puppet-collectd/issues/33)

**Merged pull requests:**

- Add write\_riemann plugin support [\#42](https://github.com/voxpupuli/puppet-collectd/pull/42) ([mattrco](https://github.com/mattrco))
- Added collectd::plugin::python [\#41](https://github.com/voxpupuli/puppet-collectd/pull/41) ([doismellburning](https://github.com/doismellburning))
- refactor MySQL configuration [\#40](https://github.com/voxpupuli/puppet-collectd/pull/40) ([mmoll](https://github.com/mmoll))
- Fix link to irq plugin in README [\#38](https://github.com/voxpupuli/puppet-collectd/pull/38) ([mattrco](https://github.com/mattrco))
- Added collectd::plugin::exec [\#37](https://github.com/voxpupuli/puppet-collectd/pull/37) ([doismellburning](https://github.com/doismellburning))
- Release 1.0.0 [\#36](https://github.com/voxpupuli/puppet-collectd/pull/36) ([blkperl](https://github.com/blkperl))
- add FreeBSD support [\#35](https://github.com/voxpupuli/puppet-collectd/pull/35) ([mmoll](https://github.com/mmoll))
- Refactor plugins to use bools instead of strings [\#32](https://github.com/voxpupuli/puppet-collectd/pull/32) ([blkperl](https://github.com/blkperl))
- Add tail plugin [\#31](https://github.com/voxpupuli/puppet-collectd/pull/31) ([blkperl](https://github.com/blkperl))
- change Include to only use \*.conf files [\#30](https://github.com/voxpupuli/puppet-collectd/pull/30) ([mmoll](https://github.com/mmoll))
- add SuSE support [\#29](https://github.com/voxpupuli/puppet-collectd/pull/29) ([mmoll](https://github.com/mmoll))
- fix link to syslog plugin [\#28](https://github.com/voxpupuli/puppet-collectd/pull/28) ([mmoll](https://github.com/mmoll))
- Use correct data types for df plugin defaults [\#27](https://github.com/voxpupuli/puppet-collectd/pull/27) ([doismellburning](https://github.com/doismellburning))

## [v0.1.0](https://github.com/voxpupuli/puppet-collectd/tree/v0.1.0) (2013-09-28)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/0.0.5...v0.1.0)

**Closed issues:**

- Send data to multiple servers [\#22](https://github.com/voxpupuli/puppet-collectd/issues/22)

**Merged pull requests:**

- Release 0.1.0 [\#26](https://github.com/voxpupuli/puppet-collectd/pull/26) ([blkperl](https://github.com/blkperl))
- Add collectd::plugin::curl\_json \(define, not class, for multi-use\) [\#25](https://github.com/voxpupuli/puppet-collectd/pull/25) ([doismellburning](https://github.com/doismellburning))
- change write\_network to accept a hash of servers [\#24](https://github.com/voxpupuli/puppet-collectd/pull/24) ([mmoll](https://github.com/mmoll))
- add apache plugin [\#23](https://github.com/voxpupuli/puppet-collectd/pull/23) ([mmoll](https://github.com/mmoll))

## [0.0.5](https://github.com/voxpupuli/puppet-collectd/tree/0.0.5) (2013-09-25)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/0.0.4...0.0.5)

**Closed issues:**

- Add snmp plugin [\#11](https://github.com/voxpupuli/puppet-collectd/issues/11)
- Add write\_network plugin  [\#10](https://github.com/voxpupuli/puppet-collectd/issues/10)

**Merged pull requests:**

- add ntpd plugin [\#19](https://github.com/voxpupuli/puppet-collectd/pull/19) ([mmoll](https://github.com/mmoll))
- Added tcpconns plugin and example for it in README [\#18](https://github.com/voxpupuli/puppet-collectd/pull/18) ([tripledes](https://github.com/tripledes))
- Adding a new generic write\_network plugin define [\#17](https://github.com/voxpupuli/puppet-collectd/pull/17) ([TimPollard](https://github.com/TimPollard))
- Added memcached plugin and example for it in README [\#16](https://github.com/voxpupuli/puppet-collectd/pull/16) ([tripledes](https://github.com/tripledes))
- SNMP, filecount and unixsock [\#14](https://github.com/voxpupuli/puppet-collectd/pull/14) ([tripledes](https://github.com/tripledes))
- Add testing docs to README [\#12](https://github.com/voxpupuli/puppet-collectd/pull/12) ([blkperl](https://github.com/blkperl))

## [0.0.4](https://github.com/voxpupuli/puppet-collectd/tree/0.0.4) (2013-09-02)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/0.0.3...0.0.4)

**Merged pull requests:**

- Add basic rspec-system test [\#9](https://github.com/voxpupuli/puppet-collectd/pull/9) ([blkperl](https://github.com/blkperl))
- nginx plugin [\#7](https://github.com/voxpupuli/puppet-collectd/pull/7) ([x-way](https://github.com/x-way))
- Network plugin [\#6](https://github.com/voxpupuli/puppet-collectd/pull/6) ([x-way](https://github.com/x-way))
- Depend on newer version of stdlib [\#5](https://github.com/voxpupuli/puppet-collectd/pull/5) ([agenticarus](https://github.com/agenticarus))
- added colorz to the README [\#4](https://github.com/voxpupuli/puppet-collectd/pull/4) ([bajr](https://github.com/bajr))
- The missing PR [\#3](https://github.com/voxpupuli/puppet-collectd/pull/3) ([tripledes](https://github.com/tripledes))

## [0.0.3](https://github.com/voxpupuli/puppet-collectd/tree/0.0.3) (2013-05-27)
[Full Changelog](https://github.com/voxpupuli/puppet-collectd/compare/0.0.2...0.0.3)

**Merged pull requests:**

- A couple of fixes and little more flexibility for graphite plugin [\#2](https://github.com/voxpupuli/puppet-collectd/pull/2) ([tripledes](https://github.com/tripledes))

## [0.0.2](https://github.com/voxpupuli/puppet-collectd/tree/0.0.2) (2013-05-09)
**Merged pull requests:**

- Added minor changes for more convinient configuration [\#1](https://github.com/voxpupuli/puppet-collectd/pull/1) ([tripledes](https://github.com/tripledes))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
