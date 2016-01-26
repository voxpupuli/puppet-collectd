require 'spec_helper_acceptance'

describe 'collectd class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'collectd': }
      EOS

      # Run it twice and test for idempotency
      execute_manifest(pp, :catch_failures => true)
      execute_manifest(pp, :catch_changes  => true)
    end

    describe package('collectd') do
      it { should be_installed }
    end

    describe service('collectd') do
      it { should be_running }
    end
  end
end
