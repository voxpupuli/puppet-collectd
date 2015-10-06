require 'spec_helper'

describe 'collectd::plugin::genericjmx::mbean', :type => :define do
  let(:facts) do
    {
      :osfamily => 'Debian',
      :id => 'root',
      :concat_basedir => tmpfilename('collectd-genericjmx-mbean'),
      :path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    }
  end

  let(:config_filename) { '/etc/collectd/conf.d/15-genericjmx.conf' }

  let(:default_params) do
    {
      :object_name => 'bar',
      :values      => [],
    }
  end

  let(:title) { 'foo' }
  let(:concat_fragment_name) { 'collectd_plugin_genericjmx_conf_foo' }

  # empty values array is technically not valid, but we'll test those cases later
  context 'defaults' do
    let(:params) { default_params }
    it 'provides an MBean stanza concat fragment' do
      should contain_concat__fragment(concat_fragment_name).with(:target => config_filename,
                                                                 :order  => '10',)
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(%r{<MBean "foo">\s+ObjectName "bar".+</MBean>}m) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(/InstancePrefix/) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(/InstanceFrom/) }
  end

  context 'instance_prefix set' do
    let(:params) do
      default_params.merge(:instance_prefix => 'baz')
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(/InstancePrefix "baz"/) }
  end

  context 'instance_from array' do
    let(:params) do
      default_params.merge(:instance_from => %w( foo bar baz ))
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(/InstanceFrom "foo"\s+InstanceFrom "bar"\s+InstanceFrom "baz"/) }
  end

  context 'instance_from string' do
    let(:params) do
      default_params.merge(:instance_from => 'bat')
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(/InstanceFrom "bat"/) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(/(.*InstanceFrom.*){2,}/) }
  end

  let(:default_values_args) do
    {
      'type'       => 'foo',
      'attribute'  => 'bar'
    }
  end

  # testing the Value template section is going to be messy
  context 'value section defaults' do
    let(:params) do
      default_params.merge(:values => [default_values_args])
    end

    it 'should have a value stanza' do
      should contain_concat__fragment(concat_fragment_name).with_content(%r{<Value>.*</Value>}m)
    end

    it 'should have only one value stanza' do
      should contain_concat__fragment(concat_fragment_name).without_content(/(.*<Value>.*){2,}/)
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(/Type "foo"/) }
    it { should contain_concat__fragment(concat_fragment_name).with_content(/Table false/) }
    it { should contain_concat__fragment(concat_fragment_name).with_content(/Attribute "bar"/) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(/InstancePrefix/) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(/InstanceFrom/) }
  end

  context 'value section instance_prefix set' do
    let(:params) do
      default_params.merge(:values => [default_values_args.merge('instance_prefix' => 'baz',)])
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(/InstancePrefix "baz"/) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(/InstanceFrom/) }
  end

  context 'value section instance_from array' do
    let(:params) do
      default_params.merge(:values => [default_values_args.merge('instance_from' => %w( alice bob carol ))])
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(/InstanceFrom "alice"/) }
    it { should contain_concat__fragment(concat_fragment_name).with_content(/InstanceFrom "bob"/) }
    it { should contain_concat__fragment(concat_fragment_name).with_content(/InstanceFrom "carol"/) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(/InstancePrefix/) }
  end

  context 'value section instance_from string' do
    let(:params) do
      default_params.merge(:values => [default_values_args.merge('instance_from' => 'dave',)])
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(/InstanceFrom "dave"/) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(/(.*InstancePrefix.*){2,}/) }
    it { should contain_concat__fragment(concat_fragment_name).without_content(/InstancePrefix/) }
  end

  context 'value section table true-like' do
    ['true', true].each do |truthy|
      let(:params) do
        default_params.merge(:values => [default_values_args.merge('table' => truthy)])
      end

      it { should contain_concat__fragment(concat_fragment_name).with_content(/Table true/) }
    end
  end

  context 'value section table false-like' do
    ['false', false].each do |truthy|
      let(:params) do
        default_params.merge(:values => [default_values_args.merge('table' => truthy)])
      end

      it { should contain_concat__fragment(concat_fragment_name).with_content(/Table false/) }
    end
  end

  context 'multiple values' do
    let(:params) do
      default_params.merge(:values => [default_values_args, default_values_args])
    end

    it { should contain_concat__fragment(concat_fragment_name).with_content(%r{(.*<Value>.*</Value>.*){2}}m) }
  end
end
