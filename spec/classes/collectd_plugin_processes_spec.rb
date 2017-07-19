require 'spec_helper'

describe 'collectd::plugin::processes', type: :class do
  on_supported_os(test_on).each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      options = os_specific_options(facts)
      context ':ensure => present' do
        context ':ensure => present and default parameters' do
          it "Will create #{options[:plugin_conf_dir]}/10-processes.conf to load the plugin" do
            is_expected.to contain_file('processes.load').with(
              ensure: 'present',
              path: "#{options[:plugin_conf_dir]}/10-processes.conf",
              content: %r{LoadPlugin processes}
            )
          end

          it "Will create #{options[:plugin_conf_dir]}/processes-config.conf" do
            is_expected.to contain_concat("#{options[:plugin_conf_dir]}/processes-config.conf").that_requires('File[collectd.d]')
            is_expected.to contain_concat__fragment('collectd_plugin_processes_conf_header').with(
              content: %r{<Plugin processes>},
              target: "#{options[:plugin_conf_dir]}/processes-config.conf",
              order: '00'
            )
          end

          it "Will create #{options[:plugin_conf_dir]}/processes-config.conf" do
            is_expected.to contain_concat__fragment('collectd_plugin_processes_conf_footer').with(
              content: %r{</Plugin>},
              target: "#{options[:plugin_conf_dir]}/processes-config.conf",
              order: '99'
            )
          end
        end
      end
    end
  end
end
