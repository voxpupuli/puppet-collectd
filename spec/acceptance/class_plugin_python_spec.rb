require 'spec_helper_acceptance'

describe 'collectd::plugin::python class' do
  context 'basic parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class{'collectd::plugin::python':
      }
      EOS
      # Run 3 times since the collectd_version
      # fact is impossible until collectd is
      # installed. This acceptance test happens
      # to be first.
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe service('collectd') do
      it { is_expected.to be_running }
    end
  end

  context 'trivial module' do
    it 'works idempotently with no errors' do
      pp = <<-EOS
      if $facts['os']['family'] == 'Debian' {
        # for collectdctl command
        package{'collectd-utils':
	  ensure => present,
        }
      }
      package{'python-pip':
        ensure => present,
      }
      package{['collectd-connect-time']:
	ensure   => 'present',
        provider => 'pip',
	require  => Package['python-pip'],
	before   => Service['collectd'],
      }
      class{'collectd::plugin::python':
	logtraces   => true,
	interactive => false,
        modules     => {
           'collectd_connect_time' => {
	     config => [{'target' => 'google.de'}],
	   },
	},
      }
      class{'collectd::plugin::unixsock':
        socketfile => '/var/run/collectd-sock',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
      shell('sleep 10')
    end
    describe service('collectd') do
      it { is_expected.to be_running }
    end
    # Check metric is really there.
    describe command('collectdctl -s /var/run/collectd-sock listval') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match %r{google.de} }
    end
  end

  context 'two instances using same python module' do
    it 'works idempotently with no errors' do
      pp = <<-EOS
      if $facts['os']['family'] == 'Debian' {
        # for collectdctl command
        package{['collectd-utils','python-dbus']:
	  ensure => present,
        }
      }
      package{['git','python-pip']:
        ensure => present,
	before => Package['collectd-systemd'],
      }
      package{'collectd-systemd':
	ensure   => 'present',
        provider => 'pip',
	source   => 'git+https://github.com/mbachry/collectd-systemd.git',
	before   => Service['collectd'],
      }
      class{'collectd':
        typesdb => ['/usr/share/collectd/types.db'],
      }
      class{'collectd::plugin::python':
	logtraces   => true,
	interactive => false,
        modules     => {
           'instanceA' => {
	     module => 'collectd_systemd',
	     config => [{'Service' => 'collectd'}],
	   },
           'instanceB' => {
	     module => 'collectd_systemd',
	     config => [{'Service' => 'sshd'}],
	   },
	},
      }
      class{'collectd::plugin::unixsock':
        socketfile => '/var/run/collectd-sock',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
      shell('sleep 10')
    end
    describe service('collectd') do
      it { is_expected.to be_running }
    end
    # Check metric is really there.
    describe command('collectdctl -s /var/run/collectd-sock listval') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match %r{systemd-sshd} }
    end
    describe command('collectdctl -s /var/run/collectd-sock listval') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match %r{systemd-collectd} }
    end
  end
end
