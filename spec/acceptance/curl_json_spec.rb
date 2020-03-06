require 'spec_helper_acceptance'

describe 'curl_json defined type' do
  context 'basic parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      collectd::plugin::curl_json {
        'date_json_request':
          url => 'http://date.jsontest.com/',
          instance => 'date_json_request',
          interval => '300',
          keys => {
            'milliseconds_since_epoch' => {
              'type'     => 'count',
              'instance' => 'epoch',
            },
          }
      }
      # Adding one write plugin removes a lot
      # of confusing/misleading warnings in collectd logs
      class { 'collectd::plugin::csv':}
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    case fact('osfamily')
    when 'Debian'
      curl_json_package = if fact('lsbdistcodename') == 'precise'
                            'libyajl1'
                          else
                            'libyajl2'
                          end
    when 'RedHat'
      curl_json_package = 'collectd-curl_json'
    end

    describe package(curl_json_package) do
      it { is_expected.to be_installed }
    end
  end
end
