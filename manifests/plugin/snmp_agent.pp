# Class: collectd::plugin::snmp_agent
#
# @see https://wiki.opnfv.org/display/fastpath/SNMP+Agent+HLD
#
#  Configues snmp agent plugin.
#
# @param ensure String Passed to package and collectd::plugin resources (both). Default: present
# @param data Optional[Hash[String[1],Collectd::SNMP_AGENT::Data]] Defines scalar field, must be put outside Table block.
# @param table Hash[String[1], Collectd::SNMP_AGENT::Table] Defines a table consisting of several Data blocks being its columns
class collectd::plugin::snmp_agent (
  Enum['present', 'absent'] $ensure = 'present',
  Optional[Hash[String[1],Collectd::SNMP_AGENT::Data]] $data = {
    'memAvailReal' => {
      'oids' => '1.3.6.1.4.1.2021.4.6.0',
      'plugin' => 'memory',
      'type' => 'memory',
      'typeinstance' => 'free',
    },
  },
  Hash[String[1], Collectd::SNMP_AGENT::Table] $table = {
    'ifTable' => {
      'indexoid' => 'IF-MIB::ifIndex',
      'sizeoid' => 'IF-MIB::ifNumber',
      'data'=> {
        'ifDescr' => {
          'plugin'   => 'interface',
          'oids'     => 'IF-MIB::ifDescr',
          'indexkey' => {
            'source' => 'PluginInstance',
          },
        },
        'ifOctets' => {
          'plugin'   => 'interface',
          'oids'     => 'IF-MIB::ifInOctets" "IF-MIB::ifOutOctets',
          'type'     => 'if_octets',
          'typeinstance' => '',
        },
      },
    },
  }
) {
  include collectd

  collectd::plugin { 'snmp_agent':
    ensure  => $ensure,
    content => epp('collectd/plugin/snmp_agent.conf.epp', {
        'data'  => $data,
        'table' => $table
    }),
  }
}
