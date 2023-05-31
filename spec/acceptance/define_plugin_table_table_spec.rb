# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'collectd::plugin::table::table' do
  context 'basic parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class{'collectd':
        utils        => true,
        purge        => true,
        recurse      => true,
        purge_config => true,
      }

      # ubuntu 18.04 has old collectd version.
      $_plugin = $facts['os']['release']['major'] ? {
        '18.04' => undef,
        default => 'uptime',
      }
      collectd::plugin::table::table{'/proc/uptime':
        table =>  {
          'plugin'    => $_plugin,
          'instance'  => 'first',
          'separator' => ' ',
          'results' => [{
             'type'        => 'gauge',
             'values_from' => [0],
          }],
        },
      }

      # Configure one write plugin to keep logs quiet
      class{'collectd::plugin::csv':}
      # Create a socket to query
      class{'collectd::plugin::unixsock':
        socketfile  => '/var/run/collectd-sock',
        socketgroup => 'root',
        deletesocket => true,
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

      case fact('os.release.major')
      when '18.04'
        its(:stdout) { is_expected.to match %r{table-first/gauge} }
      else
        its(:stdout) { is_expected.to match %r{uptime-first/gauge} }
      end
    end
  end
end
