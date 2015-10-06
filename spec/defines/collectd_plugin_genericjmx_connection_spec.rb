require 'spec_helper'

describe 'collectd::plugin::genericjmx::connection', :type => :define do
  let(:facts) do
    {
      :osfamily => 'Debian',
      :id => 'root',
      :concat_basedir => tmpfilename('collectd-genericjmx-connection'),
      :path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    }
  end

  let(:config_filename) { '/etc/collectd/conf.d/15-genericjmx.conf' }

  let(:default_params) do
    {
      :service_url => 'foo:bar:baz',
    }
  end

  let(:title) { 'foo.example.com' }
  let(:concat_fragment_name) { 'collectd_plugin_genericjmx_conf_foo.example.com' }

  context 'required params' do
    let(:params) do
      default_params.merge(:collect => [],)
    end

    it 'provides a Connection concat fragment' do
      should contain_concat__fragment(concat_fragment_name).with(:target => config_filename,
                                                                 :order => '20',)
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(%r{<Connection>.*</Connection>}m) }
    it { should contain_concat__fragment(concat_fragment_name).with_content(/Host "foo\.example\.com"/) }
    it { should contain_concat__fragment(concat_fragment_name).with_content(/ServiceURL "foo:bar:baz"/) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(/User/) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(/Password/) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(/InstancePrefix/) }
  end

  context 'hostname override' do
    let(:params) do
      default_params.merge(:host => 'bar.example.com',
                           :collect => [],)
    end

    it 'provides a Connection concat fragment' do
      should contain_concat__fragment(concat_fragment_name).with(:target => config_filename,
                                                                 :order => '20',)
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(/Host "bar\.example\.com"/) }
  end

  context 'collect array' do
    let(:params) do
      default_params.merge(:collect => %w( foo bar baz ))
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(/Collect "foo".*Collect "bar".*Collect "baz"/m) }
  end

  context 'collect string' do
    let(:params) do
      default_params.merge(:collect => 'bat')
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(/Collect "bat"/) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(/(.*Collect.*){2,}/m) }
  end

  context 'username and password' do
    let(:params) do
      default_params.merge(:user     => 'alice',
                           :password => 'aoeuhtns',
                           :collect  => [],)
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(/User "alice"/) }
    it { should contain_concat__fragment(concat_fragment_name).with_content(/Password "aoeuhtns"/) }
  end

  context 'instance_prefix 'do
    let(:params) do
      default_params.merge(:instance_prefix => 'bat',
                           :collect  => [],)
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(/InstancePrefix "bat"/) }
  end
end
