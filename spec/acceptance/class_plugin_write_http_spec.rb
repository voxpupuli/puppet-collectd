require 'spec_helper_acceptance'

describe 'collectd::plugin::write_http class' do
  context 'basic parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class{'collectd':}
      class { 'collectd::plugin::write_http':
        nodes => {
          'collect1' => { 'url' => 'collect1.example.org', 'format' => 'JSON' },
          'collect2' => { 'url' => 'collect2.example.org'},
        }
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
  end
end
