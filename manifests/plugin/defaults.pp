class collectd::plugin::defaults (
	$ensure = present,
	$enabled_plugins = [ 
		'interface',
		'load',
		'memory',
		'syslog',
		'cpu',
		'disk',
		'swap',
		'processes',
		'users',
		'df',
		'entropy',
		'irq',
		'vmem',
		'uptime',
		'contextswitch',
		'lvm',
	],
	$plugin_config = {
		syslog => '<Plugin syslog>
	LogLevel info
</Plugin>',
		vmem => '<Plugin vmem>
	Verbose false
</Plugin>',
	}

		
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir


# list of plugins generated with
#   wget -q --no-check-certificate -O - 'https://collectd.org/wiki/index.php?title=Table_of_Plugins&action=edit' | \
#       grep '^|' | \
#       while read line; do
#           case $line in
#               *{{Plugin\|*)
#                   plugin_name=`echo "${line}" | sed 's,.*Plugin|,,;s,}},,'`
#                   plugin_urlpart=`echo "${plugin_name}" | sed 's, ,_,g'`
#                   plugin=`echo "${plugin_urlpart}" | tr 'A-Z' 'a-z' | sed 's,e-mail,email,;s,-,_,g'`
#                   plugin_url="https://collectd.org/wiki/index.php/Plugin:${plugin_urlpart}"
#               ;;
#               *\[\[Version*)
#                   version=`echo $line | sed 's,.*|,,;s,\].*,,'`
#                   echo "      ${plugin} => { version => '${version}', name => '${plugin_name}', url => '${plugin_url}' },"
#               ;;
#           esac
#       done


  $plugins = {
      amqp => { version => '5.0', name => 'AMQP', url => 'https://collectd.org/wiki/index.php/Plugin:AMQP' },
      apache => { version => '3.9', name => 'Apache', url => 'https://collectd.org/wiki/index.php/Plugin:Apache' },
      apc_ups => { version => '3.10', name => 'APC UPS', url => 'https://collectd.org/wiki/index.php/Plugin:APC_UPS' },
      apple_sensors => { version => '3.9', name => 'Apple Sensors', url => 'https://collectd.org/wiki/index.php/Plugin:Apple_Sensors' },
      aquaero => { version => '5.4', name => 'Aquaero', url => 'https://collectd.org/wiki/index.php/Plugin:Aquaero' },
      ascent => { version => '4.4', name => 'Ascent', url => 'https://collectd.org/wiki/index.php/Plugin:Ascent' },
      battery => { version => '3.7', name => 'Battery', url => 'https://collectd.org/wiki/index.php/Plugin:Battery' },
      bind => { version => '4.6', name => 'BIND', url => 'https://collectd.org/wiki/index.php/Plugin:BIND' },
      carbon => { version => '4.9', name => 'Carbon', url => 'https://collectd.org/wiki/index.php/Plugin:Carbon' },
      cgroups => { version => '5.4', name => 'cgroups', url => 'https://collectd.org/wiki/index.php/Plugin:cgroups' },
      conntrack => { version => '4.7', name => 'ConnTrack', url => 'https://collectd.org/wiki/index.php/Plugin:ConnTrack' },
      contextswitch => { version => '4.9', name => 'ContextSwitch', url => 'https://collectd.org/wiki/index.php/Plugin:ContextSwitch' },
      cpu => { version => '1.3', name => 'CPU', url => 'https://collectd.org/wiki/index.php/Plugin:CPU' },
      cpufreq => { version => '3.4', name => 'CPUFreq', url => 'https://collectd.org/wiki/index.php/Plugin:CPUFreq' },
      csv => { version => '4.0', name => 'CSV', url => 'https://collectd.org/wiki/index.php/Plugin:CSV' },
      curl => { version => '4.6', name => 'cURL', url => 'https://collectd.org/wiki/index.php/Plugin:cURL' },
      curl_json => { version => '4.8', name => 'cURL-JSON', url => 'https://collectd.org/wiki/index.php/Plugin:cURL-JSON' },
      curl_xml => { version => '4.10', name => 'cURL-XML', url => 'https://collectd.org/wiki/index.php/Plugin:cURL-XML' },
      dbi => { version => '4.6', name => 'DBI', url => 'https://collectd.org/wiki/index.php/Plugin:DBI' },
      df => { version => '3.6', name => 'DF', url => 'https://collectd.org/wiki/index.php/Plugin:DF' },
      disk => { version => '1.5', name => 'Disk', url => 'https://collectd.org/wiki/index.php/Plugin:Disk' },
      dns => { version => '3.11', name => 'DNS', url => 'https://collectd.org/wiki/index.php/Plugin:DNS' },
      email => { version => '3.11', name => 'E-Mail', url => 'https://collectd.org/wiki/index.php/Plugin:E-Mail' },
      entropy => { version => '4.0', name => 'Entropy', url => 'https://collectd.org/wiki/index.php/Plugin:Entropy' },
      exec => { version => '4.0', name => 'Exec', url => 'https://collectd.org/wiki/index.php/Plugin:Exec' },
      filecount => { version => '4.5', name => 'FileCount', url => 'https://collectd.org/wiki/index.php/Plugin:FileCount' },
      fscache => { version => '4.7', name => 'FSCache', url => 'https://collectd.org/wiki/index.php/Plugin:FSCache' },
      genericjmx => { version => '4.8', name => 'GenericJMX', url => 'https://collectd.org/wiki/index.php/Plugin:GenericJMX' },
      gmond => { version => '4.7', name => 'gmond', url => 'https://collectd.org/wiki/index.php/Plugin:gmond' },
      hddtemp => { version => '3.1', name => 'HDDTemp', url => 'https://collectd.org/wiki/index.php/Plugin:HDDTemp' },
      interface => { version => '1.0', name => 'Interface', url => 'https://collectd.org/wiki/index.php/Plugin:Interface' },
      ipmi => { version => '4.4', name => 'IPMI', url => 'https://collectd.org/wiki/index.php/Plugin:IPMI' },
      iptables => { version => '4.0', name => 'IPTables', url => 'https://collectd.org/wiki/index.php/Plugin:IPTables' },
      ipvs => { version => '4.2', name => 'IPVS', url => 'https://collectd.org/wiki/index.php/Plugin:IPVS' },
      irq => { version => '4.0', name => 'IRQ', url => 'https://collectd.org/wiki/index.php/Plugin:IRQ' },
      java => { version => '4.7', name => 'Java', url => 'https://collectd.org/wiki/index.php/Plugin:Java' },
      libvirt => { version => '4.3', name => 'libvirt', url => 'https://collectd.org/wiki/index.php/Plugin:libvirt' },
      load => { version => '1.0', name => 'Load', url => 'https://collectd.org/wiki/index.php/Plugin:Load' },
      logfile => { version => '3.9', name => 'LogFile', url => 'https://collectd.org/wiki/index.php/Plugin:LogFile' },
      lpar => { version => '5.0', name => 'LPAR', url => 'https://collectd.org/wiki/index.php/Plugin:LPAR' },
      lvm => { version => '5.4', name => 'LVM', url => 'https://collectd.org/wiki/index.php/Plugin:LVM' },
      madwifi => { version => '4.8', name => 'MadWifi', url => 'https://collectd.org/wiki/index.php/Plugin:MadWifi' },
      mbmon => { version => '3.11', name => 'MBMon', url => 'https://collectd.org/wiki/index.php/Plugin:MBMon' },
      md => { version => '5.1', name => 'MD', url => 'https://collectd.org/wiki/index.php/Plugin:MD' },
      memcachec => { version => '4.7', name => 'memcachec', url => 'https://collectd.org/wiki/index.php/Plugin:memcachec' },
      memcached => { version => '4.2', name => 'memcached', url => 'https://collectd.org/wiki/index.php/Plugin:memcached' },
      memory => { version => '1.0', name => 'Memory', url => 'https://collectd.org/wiki/index.php/Plugin:Memory' },
      mic => { version => '5.4', name => 'MIC', url => 'https://collectd.org/wiki/index.php/Plugin:MIC' },
      modbus => { version => '4.10', name => 'Modbus', url => 'https://collectd.org/wiki/index.php/Plugin:Modbus' },
      monitorus => { version => '4.9', name => 'Monitorus', url => 'https://collectd.org/wiki/index.php/Plugin:Monitorus' },
      multimeter => { version => '3.11', name => 'Multimeter', url => 'https://collectd.org/wiki/index.php/Plugin:Multimeter' },
      mysql => { version => '3.6', name => 'MySQL', url => 'https://collectd.org/wiki/index.php/Plugin:MySQL' },
      netapp => { version => '4.9', name => 'NetApp', url => 'https://collectd.org/wiki/index.php/Plugin:NetApp' },
      netlink => { version => '4.1', name => 'Netlink', url => 'https://collectd.org/wiki/index.php/Plugin:Netlink' },
      network => { version => '3.0', name => 'Network', url => 'https://collectd.org/wiki/index.php/Plugin:Network' },
      nfs => { version => '3.3', name => 'NFS', url => 'https://collectd.org/wiki/index.php/Plugin:NFS' },
      nginx => { version => '4.2', name => 'nginx', url => 'https://collectd.org/wiki/index.php/Plugin:nginx' },
      notify_desktop => { version => '4.5', name => 'Notify Desktop', url => 'https://collectd.org/wiki/index.php/Plugin:Notify_Desktop' },
      notify_email => { version => '4.5', name => 'Notify Email', url => 'https://collectd.org/wiki/index.php/Plugin:Notify_Email' },
      ntpd => { version => '3.10', name => 'NTPd', url => 'https://collectd.org/wiki/index.php/Plugin:NTPd' },
      numa => { version => '5.1', name => 'numa', url => 'https://collectd.org/wiki/index.php/Plugin:numa' },
      nut => { version => '4.0', name => 'NUT', url => 'https://collectd.org/wiki/index.php/Plugin:NUT' },
      olsrd => { version => '4.8', name => 'olsrd', url => 'https://collectd.org/wiki/index.php/Plugin:olsrd' },
      onewire => { version => '4.5', name => 'OneWire', url => 'https://collectd.org/wiki/index.php/Plugin:OneWire' },
      openvpn => { version => '4.6', name => 'OpenVPN', url => 'https://collectd.org/wiki/index.php/Plugin:OpenVPN' },
      openvz => { version => '4.9', name => 'OpenVZ', url => 'https://collectd.org/wiki/index.php/Plugin:OpenVZ' },
      oracle => { version => '4.6', name => 'Oracle', url => 'https://collectd.org/wiki/index.php/Plugin:Oracle' },
      perl => { version => '4.0', name => 'Perl', url => 'https://collectd.org/wiki/index.php/Plugin:Perl' },
      pinba => { version => '4.10', name => 'Pinba', url => 'https://collectd.org/wiki/index.php/Plugin:Pinba' },
      ping => { version => '1.0', name => 'Ping', url => 'https://collectd.org/wiki/index.php/Plugin:Ping' },
      postgresql => { version => '4.5', name => 'PostgreSQL', url => 'https://collectd.org/wiki/index.php/Plugin:PostgreSQL' },
      powerdns => { version => '4.4', name => 'PowerDNS', url => 'https://collectd.org/wiki/index.php/Plugin:PowerDNS' },
      processes => { version => '3.2', name => 'Processes', url => 'https://collectd.org/wiki/index.php/Plugin:Processes' },
      protocols => { version => '4.7', name => 'Protocols', url => 'https://collectd.org/wiki/index.php/Plugin:Protocols' },
      python => { version => '4.9', name => 'Python', url => 'https://collectd.org/wiki/index.php/Plugin:Python' },
      redis => { version => '5.0', name => 'Redis', url => 'https://collectd.org/wiki/index.php/Plugin:Redis' },
      routeros => { version => '4.9', name => 'RouterOS', url => 'https://collectd.org/wiki/index.php/Plugin:RouterOS' },
      rrdcached => { version => '4.6', name => 'RRDCacheD', url => 'https://collectd.org/wiki/index.php/Plugin:RRDCacheD' },
      rrdtool => { version => '1.0', name => 'RRDtool', url => 'https://collectd.org/wiki/index.php/Plugin:RRDtool' },
      sensors => { version => '1.4', name => 'Sensors', url => 'https://collectd.org/wiki/index.php/Plugin:Sensors' },
      serial => { version => '3.3', name => 'Serial', url => 'https://collectd.org/wiki/index.php/Plugin:Serial' },
      sigrok => { version => '5.4', name => 'sigrok', url => 'https://collectd.org/wiki/index.php/Plugin:sigrok' },
      snmp => { version => '4.1', name => 'SNMP', url => 'https://collectd.org/wiki/index.php/Plugin:SNMP' },
      statsd => { version => '5.4', name => 'StatsD', url => 'https://collectd.org/wiki/index.php/Plugin:StatsD' },
      swap => { version => '2.1', name => 'Swap', url => 'https://collectd.org/wiki/index.php/Plugin:Swap' },
      syslog => { version => '1.2', name => 'SysLog', url => 'https://collectd.org/wiki/index.php/Plugin:SysLog' },
      table => { version => '4.7', name => 'Table', url => 'https://collectd.org/wiki/index.php/Plugin:Table' },
      tail => { version => '4.4', name => 'Tail', url => 'https://collectd.org/wiki/index.php/Plugin:Tail' },
      tail_csv => { version => '5.3', name => 'Tail-CSV', url => 'https://collectd.org/wiki/index.php/Plugin:Tail-CSV' },
      tape => { version => '3.3', name => 'Tape', url => 'https://collectd.org/wiki/index.php/Plugin:Tape' },
      tcpconns => { version => '4.2', name => 'TCPConns', url => 'https://collectd.org/wiki/index.php/Plugin:TCPConns' },
      teamspeak2 => { version => '4.4', name => 'TeamSpeak2', url => 'https://collectd.org/wiki/index.php/Plugin:TeamSpeak2' },
      ted => { version => '4.7', name => 'TED', url => 'https://collectd.org/wiki/index.php/Plugin:TED' },
      thermal => { version => '4.5', name => 'thermal', url => 'https://collectd.org/wiki/index.php/Plugin:thermal' },
      tokyotyrant => { version => '4.8', name => 'TokyoTyrant', url => 'https://collectd.org/wiki/index.php/Plugin:TokyoTyrant' },
      unixsock => { version => '4.0', name => 'UnixSock', url => 'https://collectd.org/wiki/index.php/Plugin:UnixSock' },
      uptime => { version => '4.7', name => 'Uptime', url => 'https://collectd.org/wiki/index.php/Plugin:Uptime' },
      users => { version => '3.5', name => 'Users', url => 'https://collectd.org/wiki/index.php/Plugin:Users' },
      uuid => { version => '4.3', name => 'UUID', url => 'https://collectd.org/wiki/index.php/Plugin:UUID' },
      varnish => { version => '5.0', name => 'Varnish', url => 'https://collectd.org/wiki/index.php/Plugin:Varnish' },
      vmem => { version => '4.4', name => 'vmem', url => 'https://collectd.org/wiki/index.php/Plugin:vmem' },
      vserver => { version => '3.9', name => 'VServer', url => 'https://collectd.org/wiki/index.php/Plugin:VServer' },
      wireless => { version => '3.9', name => 'Wireless', url => 'https://collectd.org/wiki/index.php/Plugin:Wireless' },
      xmms => { version => '4.1', name => 'XMMS', url => 'https://collectd.org/wiki/index.php/Plugin:XMMS' },
      write_graphite => { version => '5.1', name => 'Write Graphite', url => 'https://collectd.org/wiki/index.php/Plugin:Write_Graphite' },
      write_http => { version => '4.8', name => 'Write HTTP', url => 'https://collectd.org/wiki/index.php/Plugin:Write_HTTP' },
      write_mongodb => { version => '5.1', name => 'Write MongoDB', url => 'https://collectd.org/wiki/index.php/Plugin:Write_MongoDB' },
      write_redis => { version => '5.0', name => 'Write Redis', url => 'https://collectd.org/wiki/index.php/Plugin:Write_Redis' },
      write_riemann => { version => '5.3', name => 'Write Riemann', url => 'https://collectd.org/wiki/index.php/Plugin:Write_Riemann' },
      zfs_arc => { version => '4.8', name => 'ZFS ARC', url => 'https://collectd.org/wiki/index.php/Plugin:ZFS_ARC' },

	}


  file { 'defaults.conf':
    ensure    => $collectd::plugin::defaults::ensure,
    path      => "${conf_dir}/00defaults.conf",
    mode      => '0644',
    owner     => 'root',
    group     => 'root',
    content   => template('collectd/defaults.conf.erb'),
    notify    => Service['collectd']
  }
}
