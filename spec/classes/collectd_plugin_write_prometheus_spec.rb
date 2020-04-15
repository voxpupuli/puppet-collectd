require 'spec_helper'

describe 'collectd::plugin::write_prometheus', type: :class do
  on_supported_os(baseline_os_hash).each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts.merge(collectd_version: '5.7')
      end

      options = os_specific_options(facts)
      context ':ensure => present and :port => 9103' do
        let :params do
          { port: 9103 }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-write_prometheus.conf" do
          is_expected.to contain_file('write_prometheus.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-write_prometheus.conf",
            content: %r{Port "9103"}
          )
        end
      end

      context ':ensure => absent' do
        let :params do
          { ensure: 'absent' }
        end

        it 'Will not create ' do
          is_expected.to contain_file('write_prometheus.load').with(
            ensure: 'absent',
            path: "#{options[:plugin_conf_dir]}/10-write_prometheus.conf"
          )
        end
      end
    end
  end
end
