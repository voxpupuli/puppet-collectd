require 'spec_helper'

describe 'collectd::plugin::write_kafka', type: :class do
  let :facts do
    {
      osfamily: 'Debian',
      collectd_version: '5.5.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':ensure => present and :kafka_host => \'myhost\'' do
    let :params do
      { kafka_host: 'myhost', kafka_port: '9092', topics: { 'my-topic' => { 'format' => 'JSON' } } }
    end
    it 'Will create /etc/collectd/conf.d/10-write_kafka.conf' do
      is_expected.to contain_file('write_kafka.load').with(ensure: 'present')
      is_expected.to contain_file('write_kafka.load').with(path: '/etc/collectd/conf.d/10-write_kafka.conf')
      is_expected.to contain_file('write_kafka.load').with(content: %r{Property "metadata.broker.list" "myhost:9092"})
      is_expected.to contain_file('write_kafka.load').with(content: %r{Topic "my-topic"})
      is_expected.to contain_file('write_kafka.load').with(content: %r{Format "JSON"})
    end
  end

  context ':ensure => absent' do
    let :params do
      { kafka_host: ['myhost'], ensure: 'absent' }
    end
    it 'Will not create /etc/collectd/conf.d/10-write_kafka.conf' do
      is_expected.to contain_file('write_kafka.load').with(ensure: 'absent', path: '/etc/collectd/conf.d/10-write_kafka.conf')
    end
  end

  context ':topics is a hash' do
    let :params do
      { topics: %w(test) }
    end
    it 'Will raise an error about :topics being an Array' do
      is_expected.to compile.and_raise_error(%r{Array})
    end
  end
end
