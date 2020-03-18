def os_specific_options(facts)
  case facts[:os]['family']
  when 'Gentoo'
    { package: 'app-admin/collectd', service: 'collectd', plugin_conf_dir: '/etc/collectd.d' }
  when 'Solaris'
    { package: 'CSWcollectd', service: 'cswcollectd', plugin_conf_dir: '/etc/opt/csw/collectd.d' }
  when 'FreeBSD'
    { package: 'collectd5', service: 'collectd', plugin_conf_dir: '/usr/local/etc/collectd' }
  when 'Archlinux', 'RedHat'
    { package: 'collectd', service: 'collectd', plugin_conf_dir: '/etc/collectd.d' }
  when 'Debian'
    { package: 'collectd', service: 'collectd', plugin_conf_dir: '/etc/collectd/conf.d' }
  else
    { package: 'collectd', service: 'collectd', plugin_conf_dir: '/etc/collectd' }
  end
end

def all_supported_os_hash
  {
    supported_os: [
      {
        'operatingsystem' => 'Debian',
        'operatingsystemrelease' => ['8']
      },
      {
        'operatingsystem' => 'CentOS',
        'operatingsystemrelease' => %w[7 8]
      },
      {
        'operatingsystem' => 'Ubuntu',
        'operatingsystemrelease' => %w[16.04 18.04]
      },
      {
        'operatingsystem' => 'FreeBSD',
        'operatingsystemrelease' => %w[11 12]
      },
      {
        'operatingsystem' => 'Archlinux'
      }
    ]
  }
end

def baseline_os_hash
  {
    supported_os: [
      {
        'operatingsystem' => 'CentOS',
        'operatingsystemrelease' => %w[7 8]
      }
    ]
  }
end
