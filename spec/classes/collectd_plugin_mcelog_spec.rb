require 'spec_helper'

describe 'collectd::plugin::mcelog', type: :class do
  on_supported_os(baseline_os_hash).each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      options = os_specific_options(facts)
      context ':ensure => present, default params' do
        it "Will create #{options[:plugin_conf_dir]}/10-mcelog.conf" do
          is_expected.to contain_file('mcelog.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-mcelog.conf"
          )
        end
        it { is_expected.to contain_file('mcelog.load').with(content: %r{<Memory>}) }
        it { is_expected.to contain_file('mcelog.load').with(content: %r{McelogClientSocket "/var/run/mcelog-client"}) }
        it { is_expected.to contain_file('mcelog.load').with(content: %r{PersistentNotification false}) }
      end

      context ':ensure => :mceloglogfile => true' do
        let :params do
          {
            mceloglogfile: '/var/log/mcelog'
          }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-mcelog.conf" do
          is_expected.to contain_file('mcelog.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-mcelog.conf"
          )
        end
        it { is_expected.to contain_file('mcelog.load').with(content: %r{McelogLogfile "/var/log/mcelog"}) }
      end

      context ':ensure => :memory => true' do
        let :params do
          {
            memory: {
              'mcelogclientsocket' => '/var/run/mcelog-client',
              'persistentnotification' => true
            }
          }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-mcelog.conf" do
          is_expected.to contain_file('mcelog.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-mcelog.conf"
          )
        end
        it { is_expected.to contain_file('mcelog.load').with(content: %r{<Memory>}) }
        it { is_expected.to contain_file('mcelog.load').with(content: %r{McelogClientSocket "/var/run/mcelog-client"}) }
        it { is_expected.to contain_file('mcelog.load').with(content: %r{PersistentNotification true}) }
      end
    end
  end
end
