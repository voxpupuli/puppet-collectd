require 'spec_helper'

describe 'collectd::plugin::mongodb' do
  let :facts do
    { :collectd_version => '5.2',
      :osfamily         => 'RedHat',
    }
  end
  let :params do
    {
      :db_user => 'jon',
      :db_pass => 'password',
    }
  end

  context 'with default values for all parameters' do
    it { should contain_class('collectd::plugin::mongodb') }

    it do
      should contain_file('mongodb.load').with(
        'ensure' => 'present',
      )
    end

    default_fixture = File.read(fixtures('plugins/mongodb.conf.default'))
    it { should contain_file('mongodb.load').with_content(default_fixture) }
  end

  describe 'with ensure parameter' do
    %w(present absent).each do |value|
      context "set to a valid value of #{value}" do
        let :params do
          { :ensure => value,
            :db_user => 'jon',
            :db_pass => 'password',
          }
        end

        it do
          should contain_file('mongodb.load').with(
            'ensure' => value,
          )
        end
      end
    end

    context 'set to an invalid value' do
      let :params do
        { :ensure => 'invalid',
          :db_user => 'jon',
          :db_pass => 'password',
        }
      end

      it 'should fail' do
        expect do
          should contain_class('collectd::plugin::mongodb')
        end.to raise_error(Puppet::Error, /collectd::plugin::mongodb::ensure is <invalid> and must be either 'present' or 'absent'\./)
      end
    end
  end
end
