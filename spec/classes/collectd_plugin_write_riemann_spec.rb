require 'spec_helper'

describe 'collectd::plugin::write_riemann', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '5.5.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':ensure => present and :riemann_host => \'myhost\'' do
    let :params do
      { riemann_host: 'myhost', riemann_port: '5555',
        protocol: 'TCP', batch: false, ttl_factor: '3', check_thresholds: true,
        tags: ['foo'], attributes: { 'bar' => 'baz' } }
    end
    it 'Will create /etc/collectd.d/10-write_riemann.conf' do
      is_expected.to contain_file('write_riemann.load').with(ensure: 'present')
      is_expected.to contain_file('write_riemann.load').with(path: '/etc/collectd.d/10-write_riemann.conf')
      is_expected.to contain_file('write_riemann.load').with(content: %r{Host "myhost"})
      is_expected.to contain_file('write_riemann.load').with(content: %r{Port "5555"})
      is_expected.to contain_file('write_riemann.load').with(content: %r{Protocol TCP})
      is_expected.to contain_file('write_riemann.load').with(content: %r{Batch false})
      is_expected.to contain_file('write_riemann.load').with(content: %r{TTLFactor 3})
      is_expected.to contain_file('write_riemann.load').with(content: %r{CheckThresholds true})
      is_expected.to contain_file('write_riemann.load').with(content: %r{Tag "foo"})
      is_expected.to contain_file('write_riemann.load').with(content: %r{Attribute "bar" "baz"})
    end
  end

  context ':ensure => absent' do
    let :params do
      { riemann_host: ['myhost'], ensure: 'absent' }
    end
    it 'Will not create ' do
      is_expected.to contain_file('write_riemann.load').with(ensure: 'absent',
                                                             path: '/etc/collectd.d/10-write_riemann.conf')
    end
  end

  context ':ttl_factor is a number' do
    let :params do
      { ttl_factor: 'four' }
    end
    it 'Will raise an error about :ttl_factor not being a Number' do
      is_expected.to compile.and_raise_error(%r{Expected first argument to be a Numeric or Array})
    end
  end

  context ':batch is a boolean' do
    let :params do
      { batch: 'false' }
    end
    it 'Will raise an error about :batch not being a Boolean' do
      is_expected.to compile.and_raise_error(%r{"false" is not a boolean})
    end
  end

  context ':check_thresholds is a boolean' do
    let :params do
      { check_thresholds: 'false' }
    end
    it 'Will raise an error about :check_thresholds not being a Boolean' do
      is_expected.to compile.and_raise_error(%r{"false" is not a boolean})
    end
  end

  context ':tags is an array' do
    let :params do
      { tags: 'test' }
    end
    it 'Will raise an error about :tags not being an array' do
      is_expected.to compile.and_raise_error(%r{"test" is not an Array})
    end
  end

  context ':attributes is a hash' do
    let :params do
      { attributes: 'test' }
    end
    it 'Will raise an error about :attributes not being a hash' do
      is_expected.to compile.and_raise_error(%r{"test" is not a Hash})
    end
  end
end
