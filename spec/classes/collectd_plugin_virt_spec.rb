require 'spec_helper'

describe 'collectd::plugin::virt', type: :class do
  on_supported_os(baseline_os_hash).each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      let :pre_condition do
        'include collectd'
      end

      context 'interface_format in virt.conf' do
        let :params do
          {
            connection: 'qemu:///system',
            interface_format: 'address'
          }
        end

        context 'with collectd_version < 5.0' do
          let :facts do
            facts.merge(collectd_version: '4.10.1')
          end

          it 'is ignored' do
            is_expected.to contain_file('libvirt.load').
              without_content(%r{.*InterfaceFormat \"address\".*})
          end
        end

        context 'with collectd_version >= 5.0' do
          let :facts do
            facts.merge(collectd_version: '5.0.0')
          end

          it 'is included' do
            is_expected.to contain_file('libvirt.load').
              with_content(%r{.*InterfaceFormat \"address\".*})
          end
        end

        context 'with collectd_version >= 5.5' do
          let :facts do
            facts.merge(collectd_version: '5.5.0')
          end

          it 'is included' do
            is_expected.to contain_file('virt.load').
              with_content(%r{.*InterfaceFormat \"address\".*})
          end
        end

        case facts[:os]['family']
        when 'RedHat'
          context 'on osfamily => RedHat' do
            it 'Will delete packaging config file' do
              is_expected.to contain_file('package_virt.load').with_ensure('absent')
            end
          end
        end
      end
    end
  end
end
