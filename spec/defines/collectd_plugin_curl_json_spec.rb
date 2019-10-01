require 'spec_helper'

describe 'collectd::plugin::curl_json', type: :define do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      options = os_specific_options(facts)
      let :facts do
        facts.merge(collectd_version: '4.8.0')
      end
      let(:title) { 'rabbitmq_overview' }
      let(:my_params) do
        {
          url: 'http://localhost:55672/api/overview',
          host: 'rabbitmq.example.net',
          instance: 'rabbitmq_overview',
          interval: 10,
          user: 'user',
          password: 'password',
          digest: 'false',
          verifypeer: 'false',
          verifyhost: 'false',
          cacert: '/path/to/ca.crt',
          header: 'Content-Type: application/x-www-form-urlencoded',
          post: 'secret=mysecret&foo=bar',
          timeout: 1000,
          keys: {
            'message_stats/publish' => {
              'type'     => 'gauge',
              'instance' => 'overview'
            }
          }
        }
      end
      let(:sock_params) do
        {
          url: '/run/sock',
          instance: 'rabbitmq_overview',
          keys: {
            'message_stats/publish' => {
              'type'     => 'gauge',
              'instance' => 'overview'
            }
          }
        }
      end
      let(:filename) { 'rabbitmq_overview.load' }

      context 'default params' do
        let(:params) { my_params }

        it do
          is_expected.to contain_file(filename).with(
            path: "#{options[:plugin_conf_dir]}/10-rabbitmq_overview.conf"
          )
        end

        it { is_expected.to contain_file(filename).that_notifies('Service[collectd]') }
        it { is_expected.to contain_file(filename).with_content(%r{LoadPlugin "curl_json"}) }
        it { is_expected.to contain_file(filename).with_content(%r{URL "http://localhost:55672/api/overview">}) }
        it { is_expected.to contain_file(filename).without_content(%r{\bHost}) }
        it { is_expected.to contain_file(filename).without_content(%r{Interval}) }
        it { is_expected.to contain_file(filename).with_content(%r{User "user"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Password "password"}) }
        it { is_expected.to contain_file(filename).without_content(%r{Digest}) }
        it { is_expected.to contain_file(filename).with_content(%r{VerifyPeer false}) }
        it { is_expected.to contain_file(filename).with_content(%r{VerifyHost false}) }
        it { is_expected.to contain_file(filename).with_content(%r{CACert "/path/to/ca.crt"}) }
        it { is_expected.to contain_file(filename).without_content(%r{Header}) }
        it { is_expected.to contain_file(filename).without_content(%r{Post}) }
        it { is_expected.to contain_file(filename).without_content(%r{Timeout}) }
        it { is_expected.to contain_file(filename).with_content(%r{Key "message_stats/publish">}) }
        it { is_expected.to contain_file(filename).with_content(%r{Type "gauge"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Instance "overview"}) }
      end

      context 'default params 5.3' do
        let(:params) { my_params }

        let :facts do
          facts.merge(collectd_version: '5.3.0')
        end

        it do
          is_expected.to contain_file(filename).with(
            path: "#{options[:plugin_conf_dir]}/10-rabbitmq_overview.conf"
          )
        end

        it { is_expected.to contain_file(filename).that_notifies('Service[collectd]') }
        it { is_expected.to contain_file(filename).with_content(%r{LoadPlugin "curl_json"}) }
        it { is_expected.to contain_file(filename).with_content(%r{URL "http://localhost:55672/api/overview">}) }
        it { is_expected.to contain_file(filename).without_content(%r{\bHost}) }
        it { is_expected.to contain_file(filename).with_content(%r{Instance "rabbitmq_overview"}) }
        it { is_expected.to contain_file(filename).without_content(%r{Interval}) }
        it { is_expected.to contain_file(filename).with_content(%r{User "user"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Password "password"}) }
        it { is_expected.to contain_file(filename).without_content(%r{Digest}) }
        it { is_expected.to contain_file(filename).with_content(%r{VerifyPeer false}) }
        it { is_expected.to contain_file(filename).with_content(%r{VerifyHost false}) }
        it { is_expected.to contain_file(filename).with_content(%r{CACert "/path/to/ca.crt"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Header "Content-Type: application/x-www-form-urlencoded"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Post "secret=mysecret&foo=bar"}) }
        it { is_expected.to contain_file(filename).without_content(%r{Timeout}) }
        it { is_expected.to contain_file(filename).with_content(%r{Key "message_stats/publish">}) }
        it { is_expected.to contain_file(filename).with_content(%r{Type "gauge"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Instance "overview"}) }
      end

      context 'default params 5.5' do
        let(:params) { my_params }

        let :facts do
          facts.merge(collectd_version: '5.5.0')
        end

        it do
          is_expected.to contain_file(filename).with(
            path: "#{options[:plugin_conf_dir]}/10-rabbitmq_overview.conf"
          )
        end

        it { is_expected.to contain_file(filename).that_notifies('Service[collectd]') }
        it { is_expected.to contain_file(filename).with_content(%r{LoadPlugin "curl_json"}) }
        it { is_expected.to contain_file(filename).with_content(%r{URL "http://localhost:55672/api/overview">}) }
        it { is_expected.to contain_file(filename).without_content(%r{\bHost}) }
        it { is_expected.to contain_file(filename).with_content(%r{Instance "rabbitmq_overview"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Interval 10}) }
        it { is_expected.to contain_file(filename).with_content(%r{User "user"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Password "password"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Digest false}) }
        it { is_expected.to contain_file(filename).with_content(%r{VerifyPeer false}) }
        it { is_expected.to contain_file(filename).with_content(%r{VerifyHost false}) }
        it { is_expected.to contain_file(filename).with_content(%r{CACert "/path/to/ca.crt"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Header "Content-Type: application/x-www-form-urlencoded"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Post "secret=mysecret&foo=bar"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Timeout 1000}) }
        it { is_expected.to contain_file(filename).with_content(%r{Key "message_stats/publish">}) }
        it { is_expected.to contain_file(filename).with_content(%r{Type "gauge"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Instance "overview"}) }
      end

      context 'default params 5.6' do
        let(:params) { my_params }

        let :facts do
          facts.merge(collectd_version: '5.6.0')
        end

        it do
          is_expected.to contain_file(filename).with(
            path: "#{options[:plugin_conf_dir]}/10-rabbitmq_overview.conf"
          )
        end

        it { is_expected.to contain_file(filename).that_notifies('Service[collectd]') }
        it { is_expected.to contain_file(filename).with_content(%r{LoadPlugin "curl_json"}) }
        it { is_expected.to contain_file(filename).with_content(%r{URL "http://localhost:55672/api/overview">}) }
        it { is_expected.to contain_file(filename).with_content(%r{Host "rabbitmq\.example\.net"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Instance "rabbitmq_overview"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Interval 10}) }
        it { is_expected.to contain_file(filename).with_content(%r{User "user"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Password "password"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Digest false}) }
        it { is_expected.to contain_file(filename).with_content(%r{VerifyPeer false}) }
        it { is_expected.to contain_file(filename).with_content(%r{VerifyHost false}) }
        it { is_expected.to contain_file(filename).with_content(%r{CACert "/path/to/ca.crt"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Header "Content-Type: application/x-www-form-urlencoded"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Post "secret=mysecret&foo=bar"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Timeout 1000}) }
        it { is_expected.to contain_file(filename).with_content(%r{Key "message_stats/publish">}) }
        it { is_expected.to contain_file(filename).with_content(%r{Type "gauge"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Instance "overview"}) }
      end

      context 'sock params' do
        let(:params) { sock_params }

        let :facts do
          facts.merge(collectd_version: '5.6.0')
        end

        it do
          is_expected.to contain_file(filename).with(
            path: "#{options[:plugin_conf_dir]}/10-rabbitmq_overview.conf"
          )
        end

        it { is_expected.to contain_file(filename).that_notifies('Service[collectd]') }
        it { is_expected.to contain_file(filename).with_content(%r{LoadPlugin "curl_json"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Sock "/run/sock">}) }
        it { is_expected.to contain_file(filename).without_content(%r{Host}) }
        it { is_expected.to contain_file(filename).without_content(%r{Interval}) }
        it { is_expected.to contain_file(filename).without_content(%r{User}) }
        it { is_expected.to contain_file(filename).without_content(%r{Password}) }
        it { is_expected.to contain_file(filename).without_content(%r{Digest}) }
        it { is_expected.to contain_file(filename).without_content(%r{VerifyPeer}) }
        it { is_expected.to contain_file(filename).without_content(%r{VerifyHost}) }
        it { is_expected.to contain_file(filename).without_content(%r{CACert}) }
        it { is_expected.to contain_file(filename).without_content(%r{Header}) }
        it { is_expected.to contain_file(filename).without_content(%r{Post}) }
        it { is_expected.to contain_file(filename).without_content(%r{Timeout}) }
        it { is_expected.to contain_file(filename).with_content(%r{Key "message_stats/publish">}) }
        it { is_expected.to contain_file(filename).with_content(%r{Type "gauge"}) }
        it { is_expected.to contain_file(filename).with_content(%r{Instance "overview"}) }
      end

      context 'json posts' do
        let(:post) do
          {
            'type' => 'read',
            'mbean' => 'Catalina:name="http-nio-127.0.0.1-8080",type=GlobalRequestProcessor'
          }.to_json
        end

        let(:params) do
          my_params.merge(header: 'Content-Type: application/json', post: post)
        end

        let :facts do
          facts.merge(collectd_version: '5.6.0')
        end

        it { is_expected.to contain_file(filename).with_content(%r{Header "Content-Type: application/json"}) }

        # In the regex below, we have to escape the backslashes in "{\"type\":\"read\",\"mbean\":\"Catalina:name=\\\"http-nio-127.0.0.1-8080\\\",type=GlobalRequestProcessor\"}"
        it { is_expected.to contain_file(filename).with_content(%r|Post "{\\"type\\":\\"read\\",\\"mbean\\":\\"Catalina:name=\\\\\\"http-nio-127\.0\.0\.1-8080\\\\\\",type=GlobalRequestProcessor\\"}"|) }
      end
    end
  end
end
