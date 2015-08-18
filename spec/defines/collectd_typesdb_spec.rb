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
      should contain_file('/etc/collectd/types.db')
    end
  end
end
