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
      collectd_help = Facter::Util::Resolution.exec('collectd -h') and collectd_help =~ %r{^collectd ([\w.]+), http://collectd\.org/}
      Regexp.last_match(1)
    end
  end
end
