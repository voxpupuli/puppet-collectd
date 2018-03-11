require 'spec_helper'

describe 'collectd::plugin::intel_pmu', type: :class do
  on_supported_os(test_on).each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      options = os_specific_options(facts)
      context ':ensure => present, default params' do
        it "Will create #{options[:plugin_conf_dir]}/10-intel_pmu.conf" do
          is_expected.to contain_file('intel_pmu.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-intel_pmu.conf"
          )
        end
      end

      context ':ensure => present and :report_hardware_cache_events => true' do
        let :params do
          { report_hardware_cache_events: true }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-intel_pmu.conf" do
          is_expected.to contain_file('intel_pmu.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-intel_pmu.conf",
            content: %r{ReportHardwareCacheEvents "true"}m
          )
        end
      end

      context ':ensure => present and :report_kernel_pmu_events => true' do
        let :params do
          { report_kernel_pmu_events: true }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-intel_pmu.conf" do
          is_expected.to contain_file('intel_pmu.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-intel_pmu.conf",
            content: %r{ReportKernelPMUEvents "true"}m
          )
        end
      end

      context ':ensure => present and :report_software_events => true' do
        let :params do
          { report_software_events: true }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-intel_pmu.conf" do
          is_expected.to contain_file('intel_pmu.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-intel_pmu.conf",
            content: %r{ReportSoftwareEvents "true"}m
          )
        end
      end

      context ':ensure => present and :event_list => /var/cache/pmu/GenuineIntel-6-2D-core.json' do
        let :params do
          { event_list: '/var/cache/pmu/GenuineIntel-6-2D-core.json' }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-intel_pmu.conf" do
          is_expected.to contain_file('intel_pmu.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-intel_pmu.conf",
            content: %r{EventList "/var/cache/pmu/GenuineIntel-6-2D-core.json"}m
          )
        end
      end

      context ':ensure => present and :hardware_events => L2_RQSTS.CODE_RD_HIT,L2_RQSTS.CODE_RD_MISS' do
        let :params do
          { hardware_events: ['L2_RQSTS.CODE_RD_HIT', 'L2_RQSTS.CODE_RD_MISS'] }
        end

        it "Will create #{options[:plugin_conf_dir]}/10-intel_pmu.conf" do
          is_expected.to contain_file('intel_pmu.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/10-intel_pmu.conf",
            content: %r{HardwareEvents "L2_RQSTS.CODE_RD_HIT,L2_RQSTS.CODE_RD_MISS"}m
          )
        end
      end
    end
  end
end
