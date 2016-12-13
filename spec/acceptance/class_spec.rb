require 'spec_helper_acceptance'

describe 'collectd class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class { 'collectd': }
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

      class { '::collectd::plugin::rabbitmq': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe service('collectd') do
      it { is_expected.to be_running }
    end
  end
end
