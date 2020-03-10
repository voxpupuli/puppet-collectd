require 'spec_helper_acceptance'

describe 'collectd::plugin::python class' do
  context 'basic parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class{'collectd::plugin::python':
      }
      # Enable one write plugin to make logs quieter
      class { 'collectd::plugin::csv':}
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

  context 'trivial pip module connect-time' do
    it 'works idempotently with no errors' do
      pp = <<-EOS
      if $facts['os']['family'] == 'RedHat' and $facts['os']['release']['major'] == '8'  {
        $_python_pip_package = 'python3-pip'
        $_pip_provider = 'pip3'
      } else {
        $_python_pip_package = 'python-pip'
        $_pip_provider = 'pip'
      }
      package{$_python_pip_package:
        ensure => present,
      }
      package{['collectd-connect-time']:
	      ensure   => 'present',
        provider => $_pip_provider,
	      require  => Package[$_python_pip_package],
	      before   => Service['collectd'],
      }
      class{'collectd':
        utils => true,
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
        socketfile  => '/var/run/collectd-sock',
        socketgroup => 'root',
      }
      EOS

      # Run it twice or thrice and test for idempotency
      apply_manifest(pp, catch_failures: true)
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
        package{'python-dbus':
	        ensure => present,
        }
      }
      if $facts['os']['family'] == 'RedHat' and $facts['os']['release']['major'] == '8'  {
        $_python_pip_package = 'python3-pip'
        $_pip_provider = 'pip3'
      } else {
        $_python_pip_package = 'python-pip'
        $_pip_provider = 'pip'
      }

      package{['git',$_python_pip_package]:
        ensure => present,
	      before => Package['collectd-systemd'],
      }
      # Dependency on dbus for collectd-systemd installed with pip.
      # https://github.com/mbachry/collectd-systemd/issues/11
      if $facts['os']['family'] == 'RedHat' and $facts['os']['release']['major'] == '8'  {
        package{'python3-dbus':
          ensure => present,
        }
      }

      package{'collectd-systemd':
	      ensure   => 'present',
        provider => $_pip_provider,
	      source   => 'git+https://github.com/mbachry/collectd-systemd.git',
	      before   => Service['collectd'],
      }
      class{'collectd':
        utils   => true,
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
        socketgroup => 'root',
      }
      class { 'collectd::plugin::csv':}
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
