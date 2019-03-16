include collectd

class { 'collectd::plugin::df':
  mountpoints    => ['/u'],
  fstypes        => ['nfs', 'tmpfs','autofs','gpfs','proc','devpts'],
  ignoreselected => true,
}
