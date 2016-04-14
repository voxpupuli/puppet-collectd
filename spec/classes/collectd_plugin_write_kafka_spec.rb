require 'spec_helper'

describe 'collectd::plugin::write_kafka', type: :class do
  let :facts do
    {
      osfamily: 'Debian',
      collectd_version: '5.5.0',
    }
  end

  context ':ensure => present and :kafka_host => \'myhost\'' do
    let :params do
      { kafka_host: 'myhost', kafka_port: '9092', topics: { 'my-topic' => { 'format' => 'JSON' } } }
    end
    it 'Will create /etc/collectd/conf.d/10-write_kafka.conf' do
      should contain_file('write_kafka.load').with(ensure: 'present',)
      should contain_file('write_kafka.load').with(path: '/etc/collectd/conf.d/10-write_kafka.conf',)
      should contain_file('write_kafka.load').with(content: /Property "metadata.broker.list" "myhost:9092"/,)
      should contain_file('write_kafka.load').with(content: /Topic "my-topic"/,)
      should contain_file('write_kafka.load').with(content: /Format "JSON"/,)
    end
  end

  context ':ensure => absent' do
    let :params do
      { kafka_host: ['myhost'], ensure: 'absent' }
    end
    it 'Will not create /etc/collectd/conf.d/10-write_kafka.conf' do
      should contain_file('write_kafka.load').with(ensure: 'absent', path: '/etc/collectd/conf.d/10-write_kafka.conf',)
    end
  end

  context ':topics is a hash' do
    let :params do
      { topics: %w(test) }
    end
    it 'Will raise an error about :topics being an Array' do
      should compile.and_raise_error(/Array/)
    end
  end
end
