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
		if collectd_help = Facter::Util::Resolution.exec('collectd -h') \
			and collectd_help =~ /^collectd ([0-9.]+), http:\/\/collectd.org\//

				$1
		else
				nil
		end
	end
end

