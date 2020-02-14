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

      context ':ensure => log parser created with logfile' do
        let :params do
          {
            logfile:[
            'file01.log' => {
                'message' => [
                  'msg_1' => {
                    'defaultplugininstance' => 'plugin_instance',
                    'defaulttype' => 'type',
                    'defaulttypeinstance' => 'type_instance',
                    'defaultseverity' => 'ok',
                    'match' => [
                      'sample_error' => {
                        'regex' => 'regex',
                        'submatchidx' => 0,
                        'excluderegex' => 'exclude',
                        'ismandatory' => false,
                        'severity' => 'severity',
                        'plugininstance' => 'plugin_instance',
                        'type' => 'type',
                        'typeinstance' => 'type_instance'
                      }
                    ]
                  }
                ],
                'firstfullread' => false
            }
            ]
          }
        end

        it "Will create #{options[:plugin_conf_dir]}/06-log_parser.conf" do
          is_expected.to contain_file('log_parser.load').with(
            ensure: 'present',
            path: "#{options[:plugin_conf_dir]}/06-log_parser.conf"
          )
        end
      end

    end
  end
end
