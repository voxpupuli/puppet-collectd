require 'spec_helper'

describe 'collectd::plugin::iptables', type: :class do
  on_supported_os(test_on).each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      options = os_specific_options(facts)
      let :pre_condition do
        'include ::collectd'
      end

      context ':ensure => present and :chains => { \'nat\' => \'In_SSH\' }' do
        let :params do
          { chains: { 'nat' => 'In_SSH' } }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-iptables.conf" do
          is_expected.to contain_file('iptables.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-iptables.conf",
            content: %r{Chain nat In_SSH}
          )
        end
      end

      context ':ensure => present and :chains6 => { \'filter\' => \'In6_SSH\' }' do
        let :params do
          { chains6: { 'filter' => 'In6_SSH' } }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-iptables.conf" do
          is_expected.to contain_file('iptables.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-iptables.conf",
            content: %r{Chain6 filter In6_SSH}
          )
        end
      end

      context ':ensure => present and :chains has two chains from the same table' do
        let :params do
          { chains: {
            'filter' => %w[INPUT OUTPUT]
          } }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-iptables.conf" do
          is_expected.to contain_file('iptables.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-iptables.conf",
            content: %r{Chain filter INPUT}
          )
          is_expected.to contain_file('iptables.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-iptables.conf",
            content: %r{Chain filter OUTPUT}
          )
        end
      end

      context ':ensure => absent' do
        let :params do
          { chains: { 'nat' => 'In_SSH' }, ensure: 'absent' }
        end

        it "Will not create #{options[:plugin_conf_dir]}/10-iptables.conf" do
          is_expected.to contain_file('iptables.load').with(
            ensure: 'absent',
            path: "#{options[:plugin_conf_dir]}/10-iptables.conf"
          )
        end
      end

      context ':chains is not a hash' do
        let :params do
          { chains: %w[nat In_SSH] }
        end

        it 'Will raise an error about :chains being an Array' do
          is_expected.to compile.and_raise_error(%r{Array})
        end
      end
    end
  end
end
