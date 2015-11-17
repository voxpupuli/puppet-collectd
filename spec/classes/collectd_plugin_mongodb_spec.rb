require 'spec_helper'

describe 'collectd::plugin::mongodb' do
  let :facts do
    { :collectd_version => '5.2',
      :osfamily         => 'RedHat',
    }
  end

  let :default_params do
    { :db_user => 'test_user',
      :db_pass => 'password',
    }
  end

  context 'with default values for all parameters' do
    let :params do
      default_params
    end

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
          default_params.merge(:ensure => "#{value}",)
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
        default_params.merge(:ensure => 'invalid',)
      end

      it 'should fail' do
        expect do
          should contain_class('collectd::plugin::mongodb')
        end.to raise_error(Puppet::Error, /collectd::plugin::mongodb::ensure is <invalid> and must be either 'present' or 'absent'\./)
      end
    end
  end

  describe 'with interval parameter' do
    ['10.0', '3600'].each do |value|
      context "set to a valid numeric of #{value}" do
        let(:params) do
          default_params.merge(:interval => "#{value}",)
        end

        it { should contain_file('mongodb.load').with_content(/\s*Interval\s+#{Regexp.escape(value)}/) }
      end
    end

    context 'set to an invalid value' do
      let :params do
        default_params.merge(:interval => 'invalid',)
      end

      it 'should fail' do
        expect do
          should contain_class('collectd::plugin::mongodb')
        end.to raise_error(Puppet::Error, /Expected first argument to be a Numeric or Array, got String/)
      end
    end
  end

  describe 'with db_host parameter' do
    context 'set to a valid IP' do
      let :params do
        default_params.merge(:db_host => '127.0.0.1',)
      end

      hostdb_fixture = File.read(fixtures('plugins/mongodb.conf.hostdb'))
      it { should contain_file('mongodb.load').with_content(hostdb_fixture) }
    end

    %w('127001', nil).each do |value|
      context 'set to and invalid IP' do
        let :params do
          default_params.merge(:db_host => "#{value}",)
        end

        it 'should fail' do
          expect do
            should contain_class('collectd::plugin::mongodb')
          end.to raise_error(Puppet::Error, /must be a valid IP address/)
        end
      end
    end
  end

  describe 'with db_user parameter' do
    context 'set to a valid user name' do
      let :params do
        default_params.merge(:db_user => 'test_user',)
      end

      confdb_fixture = File.read(fixtures('plugins/mongodb.conf.db_user'))
      it { should contain_file('mongodb.load').with_content(confdb_fixture) }
    end

    context 'undefined' do
      let :params do
        { :db_pass => 'password',
        }
      end

      it 'should fail' do
        expect do
          should contain_class('collectd::plugin::mongodb')
        end.to raise_error(Puppet::Error, /is <undef> and must be a mongodb username/)
      end
    end
  end

  describe 'with db_pass parameter' do
    context 'set to a valid password' do
      let :params do
        default_params.merge(:db_pass => 'foo',)
      end

      dbpass_fixture = File.read(fixtures('plugins/mongodb.conf.db_pass'))
      it { should contain_file('mongodb.load').with_content(dbpass_fixture) }
    end

    context 'undefined' do
      let :params do
        { :db_user => 'test_user',
        }
      end

      it 'should fail' do
        expect do
          should contain_class('collectd::plugin::mongodb')
        end.to raise_error(Puppet::Error, /collectd::plugin::mongodb::db_pass is <undef>/)
      end
    end
  end

  describe 'with configured_dbs parameter' do
    context 'set to a valid value with db_port defined and a single db' do
      let :params do
        default_params.merge(:configured_dbs => [25],
                             :db_port        => '8080',)
      end

      dbport_single_fixture = File.read(fixtures('plugins/mongodb.conf.configured_dbs_single'))
      it { should contain_file('mongodb.load').with_content(dbport_single_fixture) }
    end

    context 'set to a valid value with db_port defined and multiple DBs' do
      let :params do
        default_params.merge(:configured_dbs => [25, 26],
                             :db_port        => '8080',)
      end

      dbport_multi_fixture = File.read(fixtures('plugins/mongodb.conf.configured_dbs_multiple'))
      it { should contain_file('mongodb.load').with_content(dbport_multi_fixture) }
    end

    context 'set to a valid value with db_port undefined' do
      let :params do
        default_params.merge(:configured_dbs => [25],)
      end

      it 'should fail' do
        expect do
          should contain_class('collectd::plugin::mongodb')
        end.to raise_error(Puppet::Error, /db_port is undefined/)
      end
    end
  end

  describe 'with collectd_dir parameter' do
    context 'defined' do
      let :params do
        default_params.merge(:collectd_dir => '/tmp/collectd_test_dir',)
      end

      collectddir_fixture = File.read(fixtures('plugins/mongodb.conf.collectddir'))
      it { should contain_file('mongodb.load').with_content(collectddir_fixture) }
    end
  end
end
