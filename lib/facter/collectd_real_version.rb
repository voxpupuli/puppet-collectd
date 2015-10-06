# Fact: collectd_real_version
#
# Purpose: Retrieve collectd version if installed
#
# Resolution:
#
# Caveats:  not well tested
#
Facter.add(:collectd_real_version) do
  setcode do
    if Facter::Util::Resolution.which('collectd')
      collectd_help = Facter::Util::Resolution.exec('collectd -h')
      %r{^collectd (?<version>[\w.]+), http://collectd.org/}.match(collectd_help)[:version]
    end
  end
end
