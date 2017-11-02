require 'spec_helper'

describe 'collectd::plugin::threshold', type: :class do
  on_supported_os(test_on).each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      options = os_specific_options(facts)
      context ':ensure => present' do
        context ':ensure => present and default parameters' do
          it "Will create #{options[:plugin_conf_dir]}/10-threshold.conf to load the plugin" do
            is_expected.to contain_file('threshold.load').with(
              ensure: 'present',
              path: "#{options[:plugin_conf_dir]}/10-threshold.conf",
              content: %r{LoadPlugin threshold}
            )
          end
        end
      end
    end
  end
end
