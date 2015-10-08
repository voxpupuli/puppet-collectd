require 'spec_helper'

describe 'collectd::plugin::dns' do
  let :facts do
    { :collectd_version => '5.2',
      :osfamily         => 'RedHat',
    }
  end

  context 'with default values for all parameters' do
    it { should contain_class('collectd::plugin::dns') }

    it do
      should contain_file('dns.load').with(
        'ensure' => 'present',
      )
    end

    default_fixture = File.read(fixtures('plugins/dns.conf.default'))
    it { should contain_file('dns.load').with_content(default_fixture) }

    it { should_not contain_package('collectd-dns') }
  end

  describe 'with ensure parameter' do
    %w(present absent).each do |value|
      context "set to a valid value of #{value}" do
        let :params do
          { :ensure => value }
        end

        it do
          should contain_file('dns.load').with(
            'ensure' => value,
          )
        end
      end
    end

    context 'set to an invalid value' do
      let :params do
        { :ensure => 'invalid' }
      end

      it 'should fail' do
        expect do
          should contain_class('collectd::plugin::dns')
        end.to raise_error(Puppet::Error, /collectd::plugin::dns::ensure is <invalid> and must be either 'present' or 'absent'\./)
      end
    end
  end

  describe 'with ignoresource parameter' do
    context 'set to a valid IP address' do
      let :params do
        { :ignoresource => '10.10.10.10' }
      end

      ignoresource_fixture = File.read(fixtures('plugins/dns.conf.ignoresource'))
      it { should contain_file('dns.load').with_content(ignoresource_fixture) }
    end

    context 'set to undef' do
      it { should contain_file('dns.load').without_content(/IgnoreSource\s+10\.10\.10\.10/) }
    end

    context 'set to an invalid value' do
      let :params do
        { :ignoresource => 'not_an_ip' }
      end

      it 'should fail' do
        expect do
          should contain_class('collectd::plugin::dns')
        end.to raise_error(Puppet::Error, /collectd::plugin::dns::ignoresource is <not_an_ip> and must be a valid IP address\./)
      end
    end
  end

  describe 'with interface parameter' do
    context 'set to a valid value' do
      let :params do
        { :interface => 'eth0' }
      end

      interface_fixture = File.read(fixtures('plugins/dns.conf.interface'))
      it { should contain_file('dns.load').with_content(interface_fixture) }
    end

    context 'set to an invalid value (non-string)' do
      let :params do
        { :interface => %w(not a string) }
      end

      it 'should fail' do
        expect do
          should contain_class('collectd::plugin::dns')
        end.to raise_error(Puppet::Error, /is not a string/)
      end
    end
  end

  describe 'with interval parameter' do
    ['10.0', '3600'].each do |value|
      context "set to a valid numeric of #{value}" do
        let :params do
          { :interval => value }
        end

        it { should contain_file('dns.load').with_content(/\s*Interval\s+#{Regexp.escape(value)}/) }
      end
    end

    context 'set to an invalid value' do
      let :params do
        { :interval => 'invalid' }
      end

      it 'should fail' do
        expect do
          should contain_class('collectd::plugin::dns')
        end.to raise_error(Puppet::Error, /Expected first argument to be a Numeric or Array, got String/)
      end
    end
  end

  describe 'with selectnumericquerytypes parameter' do
    ['true', true, 'false', false].each do |value|
      context "set to valid value of #{value}" do
        let :params do
          { :selectnumericquerytypes => value }
        end

        it { should contain_file('dns.load').with_content(/\s*SelectNumericQueryTypes\s+#{Regexp.escape(value.to_s)}/) }
      end
    end

    context 'set to an invalid value (non-boolean and non-stringified boolean)' do
      let :params do
        { :selectnumericquerytypes => 'invalid' }
      end

      it 'should fail' do
        expect do
          should contain_class('collectd::plugin::dns')
        end.to raise_error(Puppet::Error, /Unknown type of boolean/)
      end
    end
  end

  describe 'with manage_package parameter' do
    ['true', true].each do |value|
      context "set to #{value}" do
        %w(present absent).each do |ensure_value|
          context "and ensure set to #{ensure_value}" do
            let :params do
              { :ensure         => ensure_value,
                :manage_package => value,
              }
            end

            it do
              should contain_package('collectd-dns').with(
                'ensure' => ensure_value,
              )
            end
          end
        end
      end

      context 'on an unsupported platform and package_name is not specified' do
        let :facts do
          { :osfamily => 'Solaris' }
        end

        let :params do
          { :manage_package => true,
            :package_name   => 'USE_DEFAULTS',
          }
        end

        it 'should fail' do
          expect do
            should contain_class('collectd::plugin::dns')
          end.to raise_error(Puppet::Error, /collectd::plugin::dns::package_name must be specified when using an unsupported OS. Supported osfamily is RedHat\. Detected is <Solaris>\./)
        end
      end

      context 'on a supported platform and package_name is specified' do
        context 'as a valid string' do
          let :params do
            { :manage_package => true,
              :package_name   => 'custom-collectd-dns',
            }
          end

          it do
            should contain_package('collectd-dns').with(
              'ensure' => 'present',
              'name'   => 'custom-collectd-dns',
            )
          end
        end

        context 'as a non-valid entry (non-string)' do
          let :params do
            { :manage_package => true,
              :package_name   => true,
            }
          end

          it 'should fail' do
            expect do
              should contain_class('collectd::plugin::dns')
            end.to raise_error(Puppet::Error, /is not a string/)
          end
        end
      end
    end

    ['false', false].each do |value|
      context "seto to #{value}" do
        let :params do
          { :manage_package => value }
        end

        it { should_not contain_package('collectd-dns') }
      end
    end

    context 'set to an invalid value (non-boolean and non-stringified boolean)' do
      let :params do
        { :manage_package => 'invalid' }
      end

      it 'should fail' do
        expect do
          should contain_class('collectd::plugin::dns')
        end.to raise_error(Puppet::Error, /Unknown type of boolean/)
      end
    end
  end
end
