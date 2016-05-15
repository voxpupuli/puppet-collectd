require 'spec_helper'

describe 'collectd::plugin::write_riemann', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '5.5.0',
    }
  end

  context ':ensure => present and :riemann_host => \'myhost\'' do
    let :params do
      { riemann_host: 'myhost', riemann_port: '5555',
        protocol: 'TCP', batch: false, ttl_factor: '3',
        tags: ['foo'], attributes: { 'bar' => 'baz' } }
    end
    it 'Will create /etc/collectd.d/10-write_riemann.conf' do
      should contain_file('write_riemann.load').with(ensure: 'present',)
      should contain_file('write_riemann.load').with(path: '/etc/collectd.d/10-write_riemann.conf',)
      should contain_file('write_riemann.load').with(content: /Host "myhost"/,)
      should contain_file('write_riemann.load').with(content: /Port "5555"/,)
      should contain_file('write_riemann.load').with(content: /Protocol TCP/,)
      should contain_file('write_riemann.load').with(content: /Batch false/,)
      should contain_file('write_riemann.load').with(content: /TTLFactor 3/,)
      should contain_file('write_riemann.load').with(content: /Tag "foo"/,)
      should contain_file('write_riemann.load').with(content: /Attribute "bar" "baz"/,)
    end
  end

  context ':ensure => absent' do
    let :params do
      { riemann_host: ['myhost'], ensure: 'absent' }
    end
    it 'Will not create ' do
      should contain_file('write_riemann.load').with(ensure: 'absent',
                                                     path: '/etc/collectd.d/10-write_riemann.conf',)
    end
  end

  context ':ttl_factor is a number' do
    let :params do
      { ttl_factor: 'four' }
    end
    it 'Will raise an error about :ttl_factor not being a Number' do
      should compile.and_raise_error(/Expected first argument to be a Numeric or Array/)
    end
  end

  context ':batch is a boolean' do
    let :params do
      { batch: 'false' }
    end
    it 'Will raise an error about :ttl_factor not being a Boolean' do
      should compile.and_raise_error(/"false" is not a boolean/)
    end
  end

  context ':tags is an array' do
    let :params do
      { tags: 'test' }
    end
    it 'Will raise an error about :tags not being an array' do
      should compile.and_raise_error(/"test" is not an Array/)
    end
  end

  context ':attributes is a hash' do
    let :params do
      { attributes: 'test' }
    end
    it 'Will raise an error about :attributes not being a hash' do
      should compile.and_raise_error(/"test" is not a Hash/)
    end
  end
end
