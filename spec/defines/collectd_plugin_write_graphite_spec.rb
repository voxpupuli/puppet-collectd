require 'spec_helper'

describe 'collectd::plugin::write_graphite::carbon', type: :define do
  on_supported_os(baseline_os_hash).each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      options = os_specific_options(facts)

      context 'protocol should not be include with version < 5.4' do
        let(:title) { 'graphite_udp' }
        let :facts do
          facts.merge(collectd_version: '5.3')
        end
        let :params do
          {
            protocol: 'udp'
          }
        end

        it "does not include protocol in #{options[:plugin_conf_dir]}/write_graphite.conf for collectd < 5.4" do
          is_expected.not_to contain_concat__fragment('collectd_plugin_write_graphite_conf_localhost_2003').with_content(%r{.*Protocol \"udp\".*})
        end
      end

      context 'protocol should be include with version >= 5.4' do
        let(:title) { 'wg' }
        let :facts do
          facts.merge(collectd_version: '5.4')
        end
        let :params do
          {
            protocol: 'udp'
          }
        end

        it "includes protocol in #{options[:plugin_conf_dir]}/write_graphite.conf for collectd >= 5.4" do
          is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_wg_udp_2003').with_content(%r{.*Protocol \"udp\".*})
        end

        it 'uses Node definition' do
          is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_wg_udp_2003').with(
            content: %r{<Node "wg">},
            target: "#{options[:plugin_conf_dir]}/write_graphite-config.conf"
          )
        end
      end

      context 'default configuration (undefined collectd version)' do
        let(:title) { 'graphite_default' }

        let :facts do
          facts.merge(collectd_version: '5.2')
        end

        it 'includes carbon configuration' do
          is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_default_tcp_2003').with(
            content: %r{<Carbon>},
            target: "#{options[:plugin_conf_dir]}/write_graphite-config.conf"
          )
        end

        it { is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_default_tcp_2003').with(content: %r{Host "localhost"}) }

        it { is_expected.to contain_concat__fragment('collectd_plugin_write_graphite_conf_graphite_default_tcp_2003').with(content: %r{Port "2003"}) }
      end
    end
  end
end
