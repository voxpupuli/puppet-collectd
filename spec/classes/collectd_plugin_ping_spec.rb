require 'spec_helper'

describe 'collectd::plugin::ping', type: :class do
  on_supported_os(test_on).each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end
      let :pre_condition do
        'include collectd'
      end

      options = os_specific_options(facts)

      context ':hosts => [\'google.com\']' do
        let :params do
          { hosts: ['google.com'] }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-ping.conf" do
          is_expected.to contain_file('ping.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-ping.conf",
            content: %r{Host "google.com"}
          )
        end
      end

      context ':hosts => [\'google.com\', \'puppetlabs.com\']' do
        let :params do
          { hosts: ['google.com', 'puppetlabs.com'] }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-ping.conf" do
          is_expected.to contain_file('ping.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-ping.conf"
          ).with_content(
            %r{Host "google.com"}
          ).with_content(
            %r{Host "puppetlabs.com"}
          )
        end
      end

      context ':ensure => absent' do
        let :params do
          { hosts: ['google.com'], ensure: 'absent' }
        end

        it "Will not create #{options[:plugin_conf_dir]}/10-ping.conf" do
          is_expected.to contain_file('ping.load').with(
            ensure: 'absent',
            path: "#{options[:plugin_conf_dir]}/10-ping.conf"
          )
        end
      end

      context ':hosts is not an array' do
        let :params do
          { hosts: 'google.com' }
        end

        it 'Will raise an error about :interfaces being a String' do
          is_expected.to compile.and_raise_error(%r{String})
        end
      end
    end
  end
end
