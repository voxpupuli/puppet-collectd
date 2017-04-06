require 'spec_helper'

describe 'collectd::plugin::openldap', type: :class do
  let :pre_condition do
    'include ::collectd'
  end
  ######################################################################
  # Default param validation, compilation succeeds
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':ensure => present, default params' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      {}
    end

    it 'Will create /etc/collectd.d/10-openldap.conf' do
      content = <<EOS
<Plugin "openldap">
  <Instance "localhost">
    URL "ldap://localhost/"
  </Instance>
</Plugin>
EOS
      is_expected.to contain_collectd__plugin('openldap').with_content(content)
    end
  end

  context ':instances param is a hash' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end

    let :params do
      {
        instances: {
          'ldap1' => {
            'url' => 'ldap://ldap1.example.com'
          },
          'ldap2' => {
            'url' => 'ldap://ldap2.example.com',
            'binddn'   => 'cn=Monitor',
            'password' => 'password'
          }
        }
      }
    end

    it 'Will create /etc/collectd.d/10-openldap.conf with two :instances params' do
      content = <<EOS
<Plugin "openldap">
  <Instance "ldap1">
    URL "ldap://ldap1.example.com"
  </Instance>
  <Instance "ldap2">
    URL "ldap://ldap2.example.com"
    BindDN "cn=Monitor"
    Password "password"
  </Instance>
</Plugin>
EOS
      is_expected.to contain_collectd__plugin('openldap').with_content(content)
    end
  end

  ######################################################################
  # Remaining parameter validation, compilation fails

  context ':interval is not default and is an integer' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      { interval: 15 }
    end

    it 'Will create /etc/collectd.d/10-openldap.conf' do
      is_expected.to contain_file('openldap.load').with(ensure: 'present',
                                                        path: '/etc/collectd.d/10-openldap.conf',
                                                        content: %r{^  Interval 15})
    end
  end

  context ':ensure => absent' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      { ensure: 'absent' }
    end

    it 'Will not create /etc/collectd.d/10-openldap.conf' do
      is_expected.to contain_file('openldap.load').with(ensure: 'absent',
                                                        path: '/etc/collectd.d/10-openldap.conf')
    end
  end
end
