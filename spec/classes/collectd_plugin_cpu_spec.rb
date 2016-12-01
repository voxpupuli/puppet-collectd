require 'spec_helper'

describe 'collectd::plugin::cpu', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':ensure => present' do
    context ':ensure => present and collectd version < 5.5' do
      it 'Will create /etc/collectd.d/10-cpu.conf to load the plugin' do
        is_expected.to contain_file('cpu.load').with(ensure: 'present',
                                                     path: '/etc/collectd.d/10-cpu.conf',
                                                     content: %r{LoadPlugin cpu})
      end

      it 'Will not include ReportByState in /etc/collectd.d/10-cpu.conf' do
        is_expected.not_to contain_file('cpu.load').with_content(%r{ReportByState})
      end

      it 'Will not include ReportByCpu in /etc/collectd.d/10-cpu.conf' do
        is_expected.not_to contain_file('cpu.load').with_content(%r{ReportByCpu})
      end

      it 'Will not include ValuesPercentage in /etc/collectd.d/10-cpu.conf' do
        is_expected.not_to contain_file('cpu.load').with_content(%r{ValuesPercentage})
      end
    end

    context 'cpu options should be set with collectd 5.5' do
      let :facts do
        {
          osfamily: 'RedHat',
          collectd_version: '5.5',
          operatingsystemmajrelease: '7',
          python_dir: '/usr/local/lib/python2.7/dist-packages'
        }
      end
      let :params do
        {
          reportbystate: false,
          reportbycpu: false,
          valuespercentage: true
        }
      end

      it 'Will include ReportByState in /etc/collectd.d/10-cpu.conf' do
        is_expected.to contain_file('cpu.load').with_content(%r{ReportByState false})
      end

      it 'Will include ReportByCpu in /etc/collectd.d/10-cpu.conf' do
        is_expected.to contain_file('cpu.load').with_content(%r{ReportByCpu false})
      end

      it 'Will include ValuesPercentage in /etc/collectd.d/10-cpu.conf' do
        is_expected.to contain_file('cpu.load').with_content(%r{ValuesPercentage true})
      end
    end

    context 'cpu options should be set with collectd 5.6' do
      let :facts do
        {
          osfamily: 'RedHat',
          collectd_version: '5.6',
          operatingsystemmajrelease: '7',
          python_dir: '/usr/local/lib/python2.7/dist-packages'
        }
      end
      let :params do
        {
          reportnumcpu: true
        }
      end

      it 'Will include ValuesPercentage in /etc/collectd.d/10-cpu.conf' do
        is_expected.to contain_file('cpu.load').with_content(%r{ReportNumCpu true})
      end
    end
  end

  context 'default parameters are not booleans' do
    let :params do
      {
        reportbystate: 'string_a',
        reportbycpu: 'string_b',
        valuespercentage: 'string_c',
        reportnumcpu: 'string_d'
      }
    end

    it 'Will raise an error about parameters not being boolean' do
      is_expected.to compile.and_raise_error(%r{bool})
    end
  end

  context ':ensure => absent' do
    let :params do
      { ensure: 'absent' }
    end
    it 'Will remove /etc/collectd.d/10-cpu.conf' do
      is_expected.to contain_file('cpu.load').with(ensure: 'absent',
                                                   path: '/etc/collectd.d/10-cpu.conf',
                                                   content: %r{LoadPlugin cpu})
    end
  end
end
