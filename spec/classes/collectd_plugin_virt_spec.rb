require 'spec_helper'

describe 'collectd::plugin::virt', type: :class do
  let :pre_condition do
    'include ::collectd'
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
        {
          osfamily: 'Debian',
          collectd_version: '4.10.1',
          operatingsystemmajrelease: '7',
          python_dir: '/usr/local/lib/python2.7/dist-packages'
        }
      end

      it 'is ignored' do
        is_expected.to contain_file('libvirt.load').
          without_content(%r{.*InterfaceFormat \"address\".*})
      end
    end

    context 'with collectd_version >= 5.0' do
      let :facts do
        {
          osfamily: 'Debian',
          collectd_version: '5.0.0',
          operatingsystemmajrelease: '7',
          python_dir: '/usr/local/lib/python2.7/dist-packages'
        }
      end

      it 'is included' do
        is_expected.to contain_file('libvirt.load').
          with_content(%r{.*InterfaceFormat \"address\".*})
      end
    end

    context 'with collectd_version >= 5.5' do
      let :facts do
        {
          osfamily: 'Debian',
          collectd_version: '5.5.0',
          operatingsystemmajrelease: '7',
          python_dir: '/usr/local/lib/python2.7/dist-packages'
        }
      end

      it 'is included' do
        is_expected.to contain_file('virt.load').
          with_content(%r{.*InterfaceFormat \"address\".*})
      end
    end
  end
end
