require 'spec_helper'

describe 'collectd::type', :type => :define do
  let :facts do
    {
      :osfamily       => 'Debian',
      :id             => 'root',
      :concat_basedir => tmpfilename('collectd-type'),
      :path           => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    }
  end

  context 'define a type' do
    let(:title) { 'index' }
    let :params do
      {
        :target => '/etc/collectd/types.db',
        :ds_type => 'ABSOLUTE',
        :min => 4,
        :max => 5,
        :ds_name => 'some_name',
      }
    end

    it 'creates an entry' do
      should contain_concat__fragment('/etc/collectd/types.db/index').with(:target => '/etc/collectd/types.db',
                                                                           :content => "index\tsome_name:ABSOLUTE:4:5",)
    end
  end
end
