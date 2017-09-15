# Fact: collectd_version
#
# Purpose: Retrieve collectd version if installed
#
# Resolution:
#
# Caveats:  not well tested
#
Facter.add(:collectd_version) do
  setcode do
    if Facter::Util::Resolution.which('collectd')
      collectd_help = Facter::Util::Resolution.exec('collectd -h')
      %r{^collectd ([\w\.]+), http://collectd\.org/}.match(collectd_help)[1]
    end
  end
end
