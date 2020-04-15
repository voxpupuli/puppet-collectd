require 'spec_helper_acceptance'

describe 'collectd::plugin::load class' do
  context 'basic parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class{'collectd':
        utils => true,
      }
      class{'collectd::plugin::load': }
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
      its(:stdout) { is_expected.to match %r{load/load$} }
      its(:stdout) { is_expected.not_to match %r{load/load-relative$} }
    end
  end
  context 'report relative false' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class{'collectd':
        utils => true,
      }
      class{'collectd::plugin::load':
        report_relative => false,
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

    describe command('collectdctl -s /var/run/collectd-sock listval') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match %r{load/load$} }
      its(:stdout) { is_expected.not_to match %r{load/load-relative$} }
    end
  end
  context 'report relative true' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class{'collectd':
        utils => true,
      }
      class{'collectd::plugin::load':
        report_relative => true,
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

    describe command('collectdctl -s /var/run/collectd-sock listval') do
      its(:exit_status) { is_expected.to eq 0 }
      # https://github.com/voxpupuli/puppet-collectd/issues/901
      # following will fail once 5.9.1 is released in EPEL8
      if fact('osfamily') == 'RedHat' && fact('os.release.major') == '8' ||
         fact('osfamily') == 'Debian' && fact('os.release.major') == '8'
        its(:stdout) { is_expected.not_to match %r{load/load-relative$} }
        its(:stdout) { is_expected.to match %r{load/load$} }
      else
        its(:stdout) { is_expected.to match %r{load/load-relative$} }
        its(:stdout) { is_expected.not_to match %r{load/load$} }
      end
    end
  end
end
