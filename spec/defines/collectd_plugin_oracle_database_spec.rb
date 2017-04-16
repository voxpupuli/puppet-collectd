require 'spec_helper'

describe 'collectd::plugin::oracle::database', type: :define do
  let(:facts) do
    {
      osfamily: 'RedHat',
      id: 'root',
      concat_basedir: '/dne',
      path: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  let(:config_filename) { '/etc/collectd.d/15-oracle.conf' }

  let(:default_params) do
    {
      connect_id: 'connect_id',
      username: 'username',
      password: 'password',
      query: []
    }
  end

  let(:title) { 'foo' }
  let(:concat_fragment_name) { 'collectd_plugin_oracle_database_foo' }

  # empty values array is technically not valid, but we'll test those cases later
  context 'defaults' do
    let(:params) { default_params }

    it 'provides an oracle database stanza concat fragment' do
      is_expected.to contain_concat__fragment(concat_fragment_name).with(target: config_filename,
                                                                         order: '20')
    end

    it { is_expected.to contain_concat__fragment(concat_fragment_name).with_content(%r{<Database "foo">\s+ConnectID "connect_id"\s+Username "username"\s+Password "password"}m) }
  end

  context 'query array' do
    let(:params) do
      default_params.merge(query: %w[foo bar baz])
    end

    it { is_expected.to contain_concat__fragment(concat_fragment_name).with_content(%r{Query "foo"\s+Query "bar"\s+Query "baz"}) }
  end
end
