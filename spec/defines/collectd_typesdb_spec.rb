require 'spec_helper'

describe 'collectd::typesdb', type: :define do
  let :facts do
    {
      osfamily: 'Debian',
      id: 'root',
      concat_basedir: '/dne',
      path: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context 'without any types' do
    let(:title) { '/etc/collectd/types.db' }

    it 'contains empty types.db' do
      is_expected.to contain_concat('/etc/collectd/types.db').with(
        ensure: 'present',
        path: '/etc/collectd/types.db'
      ).with_mode('0640')
    end
  end

  context 'with a different file mode' do
    let(:title) { '/etc/collectd/types.db' }
    let(:params) { { 'mode' => '0644' } }

    it 'contains file with different mode' do
      is_expected.to contain_concat('/etc/collectd/types.db').with(
        ensure: 'present',
        path: '/etc/collectd/types.db'
      ).with_mode('0644')
    end
  end
end
