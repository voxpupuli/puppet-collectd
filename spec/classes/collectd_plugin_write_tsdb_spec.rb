require 'spec_helper'

describe 'collectd::plugin::write_tsdb', type: :class do
  let :facts do
    {
      osfamily: 'Debian',
      collectd_version: '5.5.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end
  context 'ensure: present, default params' do
    let :facts do
      {
        osfamily: 'Debian',
        collectd_version: '5.5.0',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end

    it 'Will create /etc/collectd/conf.d/10-write_tsdb.conf' do
      is_expected.to contain_file('write_tsdb.load').with(ensure: 'present',
                                                          path: '/etc/collectd/conf.d/10-write_tsdb.conf',
                                                          content: %r{LoadPlugin write_tsdb})
    end
  end

  context 'ensure: absent' do
    let :facts do
      {
        osfamily: 'Debian',
        collectd_version: '5.5.0',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      { ensure: 'absent' }
    end

    it 'Will not create /etc/collectd/conf.d/10-write_tsdb.conf' do
      is_expected.to contain_file('write_tsdb.load').
        with(ensure: 'absent',
             path: '/etc/collectd/conf.d/10-write_tsdb.conf')
    end
  end
end
