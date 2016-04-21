require 'spec_helper'

describe 'collectd::plugin::fhcount', type: :class do
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '5.5.0',
    }
  end

  context ':ensure => present' do
    context 'fhcount options should be set with collectd 5.5' do
      let :facts do
        { osfamily: 'RedHat',
          collectd_version: '5.5',
        }
      end
      let :params do
        { valuesabsolute: false,
          valuespercentage: true,
        }
      end

      it 'Will include ValuesAbsolute in /etc/collectd.d/10-fhcount.conf' do
        should contain_file('fhcount.load').with_content(/ValuesAbsolute false/)
      end

      it 'Will include ValuesPercentage in /etc/collectd.d/10-fhcount.conf' do
        should contain_file('fhcount.load').with_content(/ValuesPercentage true/)
      end
    end
  end

  context 'default parameters are not booleans' do
    let :params do
      { valuesabsolute: 'string_b',
        valuespercentage: 'string_c',
      }
    end

    it 'Will raise an error about parameters not being boolean' do
      should compile.and_raise_error(/bool/)
    end
  end

  context ':ensure => absent' do
    let :params do
      { ensure: 'absent' }
    end
    it 'Will remove /etc/collectd.d/10-fhcount.conf' do
      should contain_file('fhcount.load').with(ensure: 'absent',
                                               path: '/etc/collectd.d/10-fhcount.conf',
                                               content: /LoadPlugin fhcount/,)
    end
  end
end
