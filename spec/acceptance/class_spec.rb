require 'spec_helper_acceptance'

describe 'collectd class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class { 'collectd': }
      # Enable one write plugin to make logs quieter
      class { 'collectd::plugin::csv':}
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('collectd') do
      it { is_expected.to be_installed }
    end

    describe service('collectd') do
      it { is_expected.to be_running }
    end
  end

  context 'install plugins' do
    it 'works idemptontently' do
      pp = <<-EOS
      class { '::collectd': }

      class { '::collectd::plugin::memory': }

      # rabbitmq plugin not ported to Python3
      unless $facts['os']['family'] == 'RedHat' and $facts['os']['release']['major'] == '8' {
        class { '::collectd::plugin::rabbitmq': }
      }
      class { 'collectd::plugin::csv':}
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    if fact('osfamily') == 'Debian'
      describe file('/etc/collectd/conf.d/10-rabbitmq.conf') do
        it { is_expected.to be_file }
        it { is_expected.to contain 'TypesDB "/usr/local/share/collectd-rabbitmq/types.db.custom"' }
      end
    end

    if fact('osfamily') == 'RedHat' && fact('os.release.major') == '7'
      describe file('/etc/collectd.d/10-rabbitmq.conf') do
        it { is_expected.to be_file }
        it { is_expected.to contain 'TypesDB "/usr/share/collectd-rabbitmq/types.db.custom"' }
      end
    end

    describe service('collectd') do
      it { is_expected.to be_running }
    end
  end
end
