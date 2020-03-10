require 'spec_helper_acceptance'

describe 'collectd::plugin::disk class' do
  context 'basic parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class{'collectd':
        utils => true,
      }
      class{'collectd::plugin::disk': }
      # Add one write plugin to keep logs quiet
      class{'collectd::plugin::csv':}
      # Create a socket to query
      class{'collectd::plugin::unixsock':
        socketfile  => '/var/run/collectd-sock',
        socketgroup => 'root',
      }

      EOS
      # Run 3 times since the collectd_version
      # fact is impossible until collectd is
      # installed.
      apply_manifest(pp, catch_failures: false)
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
      # Wait to get some data
      shell('sleep 10')
    end

    describe service('collectd') do
      it { is_expected.to be_running }
    end

    describe command('collectdctl -s /var/run/collectd-sock listval') do
      its(:exit_status) { is_expected.to eq 0 }
      # the reason debian does not report disk metrics on docker images despite the
      # module being loaded is an exercise for the reader.
      # For CentOS 7 it works on my laptop but not in travis.
      # disk plugin is probably very sensitive to environment.
      if fact('os.family') == 'Redhat' && fact('os.release.major') == '8'
        its(:stdout) { is_expected.to match %r{disk_time} }
      end
    end
  end
end
