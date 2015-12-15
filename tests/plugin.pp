include collectd

collectd::plugin { 'load':
  ensure => 'present',
}

collectd::plugin { 'battery': }
collectd::plugin { 'cpu': }
collectd::plugin { 'df': }
collectd::plugin { 'disk': }
collectd::plugin { 'entropy': }
collectd::plugin { 'interface': }
collectd::plugin { 'irq': }
collectd::plugin { 'iptables': }
collectd::plugin { 'memory': }
collectd::plugin { 'processes': }
collectd::plugin { 'swap': }
collectd::plugin { 'users': }
collectd::plugin { 'cpufreq': }
