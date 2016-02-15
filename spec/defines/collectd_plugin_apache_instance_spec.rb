require 'spec_helper'

describe 'collectd::plugin::apache::instance', :type => :define do
  let :facts do
    { :osfamily => 'Debian' }
  end

  let(:title) { 'foo.example.com' }
  let(:required_params) do
    {
      :url => 'http://localhost/mod_status?auto'
    }
  end

  let(:filename) { 'apache-instance-foo.example.com.conf' }

  context 'default params' do
    let(:params) { required_params }

    it do
      should contain_file(filename).with(
        :ensure => 'present',
        :path   => '/etc/collectd/conf.d/25-apache-instance-foo.example.com.conf'
      )
    end

    it { should contain_file(filename).that_notifies('Service[collectd]') }
    it { should contain_file(filename).with_content(/<Plugin "apache">/) }
    it { should contain_file(filename).with_content(/<Instance "foo\.example\.com">/) }
    it { should contain_file(filename).with_content(%r{URL "http://localhost/mod_status\?auto"}) }
    it { should contain_file(filename).without_content(/User "/) }
    it { should contain_file(filename).without_content(/Password "/) }
    it { should contain_file(filename).without_content(/VerifyHost "/) }
    it { should contain_file(filename).without_content(/VerifyHost "/) }
    it { should contain_file(filename).without_content(/CACert "/) }
  end

  context 'all params set' do
    let(:params) do
      required_params.merge(:url        => 'http://bar.example.com/server-status?auto',
                            :user       => 'admin',
                            :password   => 'admin123',
                            :verifypeer => 'false',
                            :verifyhost => 'false',
                            :cacert     => '/etc/ssl/certs/ssl-cert-snakeoil.pem',)
    end
    it { should contain_file(filename).with_content(%r{URL "http://bar\.example\.com/server-status\?auto"}) }
    it { should contain_file(filename).with_content(/User "admin"/) }
    it { should contain_file(filename).with_content(/Password "admin123"/) }
    it { should contain_file(filename).with_content(/VerifyPeer "false"/) }
    it { should contain_file(filename).with_content(/VerifyHost "false"/) }
    it { should contain_file(filename).with_content(%r{CACert "/etc/ssl/certs/ssl-cert-snakeoil\.pem"}) }
  end
end
