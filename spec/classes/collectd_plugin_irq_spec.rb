require 'spec_helper'

describe 'collectd::plugin::irq', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':ensure => present and :irqs => [90,91,92]' do
    let :params do
      { irqs: [90, 91, 92] }
    end
    it 'Will create /etc/collectd.d/10-irq.conf' do
      is_expected.to contain_file('irq.load').with(ensure: 'present',
                                                   path: '/etc/collectd.d/10-irq.conf',
                                                   content: %r{Irq  \"90\"\n.+Irq  \"91\"\n.+Irq  \"92\"}m)
    end
  end

  context ':ensure => absent' do
    let :params do
      { irqs: [90, 91, 92], ensure: 'absent' }
    end
    it 'Will not create /etc/collectd.d/10-irq.conf' do
      is_expected.to contain_file('irq.load').with(ensure: 'absent',
                                                   path: '/etc/collectd.d/10-irq.conf')
    end
  end

  context ':disks is not an array' do
    let :params do
      { irqs: '90,91,92' }
    end
    it 'Will raise an error about :irqs being a String' do
      is_expected.to compile.and_raise_error(%r{String})
    end
  end
end
