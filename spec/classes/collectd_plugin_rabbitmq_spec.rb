require 'spec_helper'

describe 'collectd::plugin::rabbitmq', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '5.5.1'
    }
  end

  context 'package ensure' do
    context ':ensure => present' do
      let(:node) { 'testhost.example.com' }

      it 'Load collectd_rabbitmq in python-config' do
        should contain_concat_fragment('collectd_plugin_python_conf_collectd_rabbitmq.collectd_plugin').with_content(/Module "collectd_rabbitmq.collectd_plugin"/)
      end

      it 'import collectd_rabbitmq.collectd_plugin in python-config' do
        should contain_concat_fragment('collectd_plugin_python_conf_collectd_rabbitmq.collectd_plugin').with_content(/Import "collectd_rabbitmq.collectd_plugin"/)
      end

      it 'default to Username guest in python-config' do
        should contain_concat_fragment('collectd_plugin_python_conf_collectd_rabbitmq.collectd_plugin').with_content(/Username "guest"/)
      end

      it 'default to Password guest in python-config' do
        should contain_concat_fragment('collectd_plugin_python_conf_collectd_rabbitmq.collectd_plugin').with_content(/Password "guest"/)
      end

      it 'default to Port 15672 in python-config' do
        should contain_concat_fragment('collectd_plugin_python_conf_collectd_rabbitmq.collectd_plugin').with_content(/Port "15672"/)
      end

      it 'default to Scheme http in python-config' do
        should contain_concat_fragment('collectd_plugin_python_conf_collectd_rabbitmq.collectd_plugin').with_content(/Scheme "http"/)
      end

      it 'Host should be set to $::fqdn python-config' do
        should contain_concat_fragment('collectd_plugin_python_conf_collectd_rabbitmq.collectd_plugin').with_content(/Host "testhost.example.com"/)
      end
    end

    context 'override Username to foo' do
      let :facts do
        { osfamily: 'RedHat',
          collectd_version: '5.5'
        }
      end
      let :params do
        { config: { 'Username' => 'foo' } }
      end

      it 'override Username to foo in python-config' do
        should contain_concat_fragment('collectd_plugin_python_conf_collectd_rabbitmq.collectd_plugin').with_content(/Username "foo"/)
      end
    end

    context 'override Password to foo' do
      let :facts do
        { osfamily: 'RedHat',
          collectd_version: '5.5'
        }
      end
      let :params do
        { config: { 'Password' => 'foo' } }
      end

      it 'override Username to foo in python-config' do
        should contain_concat_fragment('collectd_plugin_python_conf_collectd_rabbitmq.collectd_plugin').with_content(/Password "foo"/)
      end
    end

    context 'override Scheme to https' do
      let :facts do
        { osfamily: 'RedHat',
          collectd_version: '5.5'
        }
      end
      let :params do
        { config: { 'Scheme' => 'https' } }
      end

      it 'override Username to foo in python-config' do
        should contain_concat_fragment('collectd_plugin_python_conf_collectd_rabbitmq.collectd_plugin').with_content(/Scheme "https"/)
      end
    end
  end

  context ':ensure => absent' do
    let :params do
      { ensure: 'absent' }
    end

    it 'Will remove python-config' do
      should_not contain_concat__fragment('collectd_plugin_python_conf_collectd_rabbitmq.collectd_plugin').with(ensure: 'present')
    end
  end

  # based on manage_package from dns spec but I added support for multiple providers
  describe 'with manage_package parameter' do
    ['true', true].each do |value|
      context "set to #{value}" do
        %w(present absent).each do |ensure_value|
          %w(pip yum).each do |provider|
            %w(collectd-rabbitmq collectd_rabbitmq).each do |packagename|
              context "and ensure set to #{ensure_value} for package #{packagename} with package_provider #{provider}" do
                let :params do
                  { ensure: ensure_value,
                    manage_package: value,
                    package_name: packagename,
                    package_provider: provider
                  }
                end

                it do
                  should contain_package(packagename).with(
                    'ensure' => ensure_value,
                    'provider' => provider
                  )
                end
              end # packagename
            end # ensure set
          end # provider
        end # present absent
      end # context set
    end # 'true', true
  end # describe with manage_package
end
