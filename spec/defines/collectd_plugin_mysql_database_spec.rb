require 'spec_helper'

describe 'collectd::plugin::mysql::database', :type => :define do
  let :facts do
    {:osfamily => 'Debian'}
  end

  context ':socket => /var/run/mysqld/mysqld.sock, custom socket' do
    let(:title) { 'test' }
    let :params do
      {:socket => '/var/run/mysqld/mysqld.sock'}
    end
    it 'Will create /etc/collectd/conf.d/mysql-test.conf' do
      should contain_file('test.conf').with_content(/Socket "\/var\/run\/mysqld\/mysqld\.sock"$/)
    end
  end

  context 'no custom socket' do
    let(:title) { 'test' }
    it 'Will create /etc/collectd/conf.d/mysql-test.conf' do
      should contain_file('test.conf').without_content(/Socket/)
    end
  end
end
