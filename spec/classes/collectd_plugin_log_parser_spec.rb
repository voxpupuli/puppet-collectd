require 'spec_helper'

describe 'collectd::plugin::log_parser', type: :class do
  on_supported_os(baseline_os_hash).each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      options = os_specific_options(facts)
      context ':ensure => present, default params' do
        it "Will create #{options[:plugin_conf_dir]}/06-log_parser.conf" do
          is_expected.to contain_file('log_parser.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/06-log_parser.conf"
          )
        end
      end

      context ':ensure => log parser created with default values' do
        default_fixture = File.read(fixtures('plugins/logparser.conf.default'))
        it "Will create #{options[:plugin_conf_dir]}/06-log_parser.conf" do
          is_expected.to contain_file('log_parser.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/06-log_parser.conf",
            content: default_fixture
          )
        end
      end
    end
  end
end
