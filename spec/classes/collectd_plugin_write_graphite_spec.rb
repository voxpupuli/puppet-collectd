require 'spec_helper'

describe 'collectd::plugin::write_graphite', :type => :class do

  context 'protocol should not be include with version < 5.4' do
    let :facts do
      { :osfamily => 'RedHat',
        :collectd_version => '5.3',
      }
    end
    let :params do
      { :protocol => 'udp',
      }
    end

    it 'Should not include protocol in /etc/collectd.d/write_graphite.conf for collectd < 5.4' do
      should_not contain_file('write_graphite.conf').with_content(/.*Protocol \"udp\".*/)
    end
  end

  context 'protocol should be include with version >= 5.4' do
    let :facts do
      { :osfamily => 'RedHat',
        :collectd_version => '5.4',
      }
    end
    let :params do
      { :protocol => 'udp',
      }
    end

    it 'Should include protocol in /etc/collectd.d/write_graphite.conf for collectd >= 5.4' do
      should contain_file('write_graphite.load') \
        .with_content(/.*Protocol \"udp\".*/)
    end
  end

end
