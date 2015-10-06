require 'spec_helper'

describe 'collectd::plugin::cpu', :type => :class do
  let :facts do
    { :osfamily => 'RedHat' }
  end

  context ':ensure => present' do
    context ':ensure => present and collectd version < 5.5' do
      it 'Will create /etc/collectd.d/10-cpu.conf to load the plugin' do
        should contain_file('cpu.load').with(:ensure  => 'present',
                                             :path    => '/etc/collectd.d/10-cpu.conf',
                                             :content => /LoadPlugin cpu/,)
      end

      it 'Will not include ReportByState in /etc/collectd.d/10-cpu.conf' do
        should_not contain_file('cpu.load').with_content(/ReportByState/)
      end

      it 'Will not include ReportByCpu in /etc/collectd.d/10-cpu.conf' do
        should_not contain_file('cpu.load').with_content(/ReportByCpu/)
      end

      it 'Will not include ValuesPercentage in /etc/collectd.d/10-cpu.conf' do
        should_not contain_file('cpu.load').with_content(/ValuesPercentage/)
      end
    end

    context 'cpu options should be set with collectd 5.5' do
      let :facts do
        { :osfamily            => 'RedHat',
          :collectd_version    => '5.5',
        }
      end
      let :params do
        { :reportbystate       => false,
          :reportbycpu         => false,
          :valuespercentage    => true,
        }
      end

      it 'Will include ReportByState in /etc/collectd.d/10-cpu.conf' do
        should contain_file('cpu.load').with_content(/ReportByState = false/)
      end

      it 'Will include ReportByCpu in /etc/collectd.d/10-cpu.conf' do
        should contain_file('cpu.load').with_content(/ReportByCpu = false/)
      end

      it 'Will include ValuesPercentage in /etc/collectd.d/10-cpu.conf' do
        should contain_file('cpu.load').with_content(/ValuesPercentage = true/)
      end
    end
  end

  context 'default parameters are not booleans' do
    let :params do
      { :reportbystate    => 'string_a',
        :reportbycpu      => 'string_b',
        :valuespercentage => 'string_c',
      }
    end

    it 'Will raise an error about parameters not being boolean' do
      should compile.and_raise_error(/bool/)
    end
  end

  context ':ensure => absent' do
    let :params do
      { :ensure => 'absent' }
    end
    it 'Will remove /etc/collectd.d/10-cpu.conf' do
      should contain_file('cpu.load').with(:ensure  => 'absent',
                                           :path    => '/etc/collectd.d/10-cpu.conf',
                                           :content => /LoadPlugin cpu/,)
    end
  end
end
