# Fact: collectd_discoverd_osds
#
# Purpose: discover ceph osds
#
# Resolution:
#
# Caveats:  not well tested
#
require 'puppet'

if File.directory?('/var/lib/ceph/osd')
  Facter.add(:collectd_discoverd_osds) do
    setcode do
        input = Facter::Util::Resolution.exec('find -L /var/lib/ceph/osd -mindepth 1 -maxdepth 1 -type d -printf "%f,"')
        input.chomp(',').gsub('ceph-', 'osd.')
    end
  end
end
