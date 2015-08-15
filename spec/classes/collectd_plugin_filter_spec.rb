require 'spec_helper'

describe 'collectd::plugin::filter', type: :class do
  let :facts do
    {
      osfamily: 'Debian',
      concat_basedir: tmpfilename('collectd-filter'),
      id: 'root',
      kernel: 'Linux',
      path: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      collectd_version: '5.0'
    }
  end
  context ':ensure => present and default parameters' do
    it 'Will create /etc/collectd/conf.d/01-filter.conf to set the default Chains' do
      should contain_file('/etc/collectd/conf.d/01-filter.conf').with(ensure: 'present',
                                                                      path: '/etc/collectd/conf.d/01-filter.conf',
                                                                      content: /PreCacheChain \"PreChain\"\nPostCacheChain \"PostChain\"/)
    end
  end

  context ':ensure => present and custom parameters' do
    let(:params) do
      {
        ensure: 'present',
        precachechain: 'MyPreChain',
        postcachechain: 'MyPostChain'
      }
    end
    it 'Will create /etc/collectd/conf.d/01-filter.conf to set the default Chains' do
      should contain_file('/etc/collectd/conf.d/01-filter.conf').with(ensure: 'present',
                                                                      path: '/etc/collectd/conf.d/01-filter.conf',
                                                                      content: /PreCacheChain \"MyPreChain\"\nPostCacheChain \"MyPostChain\"/)
    end
  end

  context ':ensure => absent' do
    let(:params) do
      { ensure: 'absent' }
    end

    it 'Will remove /etc/collectd/conf.d/01-filter.conf' do
      should contain_file('/etc/collectd/conf.d/01-filter.conf').with(ensure: 'absent',
                                                                      path: '/etc/collectd/conf.d/01-filter.conf')
    end

    it 'Will remove loads of match plugins for filter' do
      should contain_file('match_regex.load').with(ensure: 'absent', path: '/etc/collectd/conf.d/02-match_regex.conf')
      should contain_file('match_timediff.load').with(ensure: 'absent', path: '/etc/collectd/conf.d/02-match_timediff.conf')
      should contain_file('match_value.load').with(ensure: 'absent', path: '/etc/collectd/conf.d/02-match_value.conf')
      should contain_file('match_empty_counter.load').with(ensure: 'absent', path: '/etc/collectd/conf.d/02-match_empty_counter.conf')
      should contain_file('match_hashed.load').with(ensure: 'absent', path: '/etc/collectd/conf.d/02-match_hashed.conf')
    end

    it 'Will remove loads of target plugins for filter' do
      should contain_file('target_notification.load').with(ensure: 'absent', path: '/etc/collectd/conf.d/02-target_notification.conf')
      should contain_file('target_replace.load').with(ensure: 'absent', path: '/etc/collectd/conf.d/02-target_replace.conf')
      should contain_file('target_set.load').with(ensure: 'absent', path: '/etc/collectd/conf.d/02-target_set.conf')
    end
  end
end
