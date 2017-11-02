require 'spec_helper'

describe 'collectd::plugin::mysql::database', type: :define do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end
      let :pre_condition do
        'include collectd'
      end

      options = os_specific_options(facts)

      context ':socket => /var/run/mysqld/mysqld.sock, custom socket' do
        let(:title) { 'test' }
        let :params do
          { socket: '/var/run/mysqld/mysqld.sock' }
        end

        it "Will create #{options[:plugin_conf_dir]}/mysql-test.conf" do
          is_expected.to contain_file('test.conf').with_content(%r{Socket "/var/run/mysqld/mysqld\.sock"$})
        end
      end

      context 'no custom socket' do
        let(:title) { 'test' }

        it "Will create #{options[:plugin_conf_dir]}/mysql-test.conf" do
          is_expected.to contain_file('test.conf').without_content(%r{Socket})
        end
      end
    end
  end
end
