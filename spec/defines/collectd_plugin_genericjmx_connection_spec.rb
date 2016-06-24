require 'spec_helper'

describe 'collectd::plugin::genericjmx::connection', type: :define do
  let(:facts) do
    {
      osfamily: 'Debian',
      id: 'root',
      concat_basedir: '/dne',
      path: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      collectd_version: '4.8.0'
    }
  end

  let(:config_filename) { '/etc/collectd/conf.d/15-genericjmx.conf' }

  let(:default_params) do
    {
      service_url: 'foo:bar:baz'
    }
  end

  let(:title) { 'foo.example.com' }
  let(:concat_fragment_name) { 'collectd_plugin_genericjmx_conf_foo.example.com' }

  context 'required params' do
    let(:params) do
      default_params.merge(collect: [])
    end

    it 'provides a Connection concat fragment' do
      should contain_concat__fragment(concat_fragment_name).with(target: config_filename,
                                                                 order: '20')
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(%r{<Connection>.*</Connection>}m) }
    it { should contain_concat__fragment(concat_fragment_name).with_content(%r{Host "foo\.example\.com"}) }
    it { should contain_concat__fragment(concat_fragment_name).with_content(%r{ServiceURL "foo:bar:baz"}) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(%r{User}) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(%r{Password}) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(%r{InstancePrefix}) }
  end

  context 'hostname override' do
    let(:params) do
      default_params.merge(host: 'bar.example.com',
                           collect: [])
    end

    it 'provides a Connection concat fragment' do
      should contain_concat__fragment(concat_fragment_name).with(target: config_filename,
                                                                 order: '20')
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(%r{Host "bar\.example\.com"}) }
  end

  context 'collect array' do
    let(:params) do
      default_params.merge(collect: %w( foo bar baz ))
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(%r{Collect "foo".*Collect "bar".*Collect "baz"}m) }
  end

  context 'collect string' do
    let(:params) do
      default_params.merge(collect: 'bat')
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(%r{Collect "bat"}) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(%r{(.*Collect.*){2,}}m) }
  end

  context 'username and password' do
    let(:params) do
      default_params.merge(user: 'alice',
                           password: 'aoeuhtns',
                           collect: [])
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(%r{User "alice"}) }
    it { should contain_concat__fragment(concat_fragment_name).with_content(%r{Password "aoeuhtns"}) }
  end

  context 'instance_prefix ' do
    let(:params) do
      default_params.merge(instance_prefix: 'bat',
                           collect: [])
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(%r{InstancePrefix "bat"}) }
  end
end
