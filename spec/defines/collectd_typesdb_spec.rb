require 'spec_helper'

describe 'collectd::typesdb', :type => :define do
  let :facts do
    {
      :osfamily       => 'Debian',
      :id             => 'root',
      :concat_basedir => tmpfilename('collectd-typesdb'),
      :path           => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    }
  end

  context 'without any types' do
    let(:title) { '/etc/collectd/types.db' }

    it 'should contain empty types.db' do
      should contain_concat('/etc/collectd/types.db')
      should contain_file('/etc/collectd/types.db').with_mode('0640')
    end
  end

  context 'with a different file mode' do
    let(:title) { '/etc/collectd/types.db' }
    let(:params) { { 'mode' => '0644' } }

    it 'should contain file with different mode' do
      should contain_file('/etc/collectd/types.db').with_mode('0644')
    end
  end
end
