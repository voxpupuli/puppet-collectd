require 'spec_helper_acceptance'

describe 'collectd::plugin::ovs_stats class', unless: default[:platform] =~ %r{ubuntu} do
  context 'basic parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class{'collectd':
        utils => true,
      }
      class{ 'collectd::plugin::ovs_stats':
        port => 6639,
      }
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

    # it is expected to unload the ovs_stats plugin, since there
    # is no ovs running inside the docker container.
    # At the same time, collectd should continue to run.
    describe command('collectdctl -s /var/run/collectd-sock listval') do
      its(:exit_status) { is_expected.to eq 0 }
    end
  end
end
