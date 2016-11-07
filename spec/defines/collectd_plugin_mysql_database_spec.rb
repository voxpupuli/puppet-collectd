require 'spec_helper'

describe 'collectd::plugin::mysql::database', type: :define do
  let :pre_condition do
    'include ::collectd'
  end

  let :facts do
    {
      osfamily: 'Debian',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':socket => /var/run/mysqld/mysqld.sock, custom socket' do
    let(:title) { 'test' }
    let :params do
      { socket: '/var/run/mysqld/mysqld.sock' }
    end
    it 'Will create /etc/collectd/conf.d/mysql-test.conf' do
      is_expected.to contain_file('test.conf').with_content(%r{Socket "/var/run/mysqld/mysqld\.sock"$})
    end
  end

  context 'no custom socket' do
    let(:title) { 'test' }
    it 'Will create /etc/collectd/conf.d/mysql-test.conf' do
      is_expected.to contain_file('test.conf').without_content(%r{Socket})
    end
  end
end
