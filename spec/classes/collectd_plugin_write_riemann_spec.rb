require 'spec_helper'

describe 'collectd::plugin::write_riemann', type: :class do
  on_supported_os(test_on).each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      options = os_specific_options(facts)
      context ':ensure => present and :riemann_host => "myhost"' do
        let :params do
          { riemann_host: 'myhost', riemann_port: '5555',
            protocol: 'TCP', batch: false, ttl_factor: '3', check_thresholds: true,
            tags: ['foo'], attributes: { 'bar' => 'baz' } }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-write_riemann.conf" do
          is_expected.to contain_file('write_riemann.load').with(ensure: 'present')
          is_expected.to contain_file('write_riemann.load').with(path: "#{options[:plugin_conf_dir]}/10-write_riemann.conf")
          is_expected.to contain_file('write_riemann.load').with(content: %r{Host "myhost"})
          is_expected.to contain_file('write_riemann.load').with(content: %r{Port "5555"})
          is_expected.to contain_file('write_riemann.load').with(content: %r{Protocol TCP})
          is_expected.to contain_file('write_riemann.load').with(content: %r{Batch false})
          is_expected.to contain_file('write_riemann.load').with(content: %r{TTLFactor 3})
          is_expected.to contain_file('write_riemann.load').with(content: %r{CheckThresholds true})
          is_expected.to contain_file('write_riemann.load').with(content: %r{Tag "foo"})
          is_expected.to contain_file('write_riemann.load').with(content: %r{Attribute "bar" "baz"})
        end
      end

      context ':ensure => absent' do
        let :params do
          { riemann_host: ['myhost'], ensure: 'absent' }
        end

        it 'Will not create ' do
          is_expected.to contain_file('write_riemann.load').with(
            ensure: 'absent',
            path: "#{options[:plugin_conf_dir]}/10-write_riemann.conf"
          )
        end
      end
    end
  end
end
