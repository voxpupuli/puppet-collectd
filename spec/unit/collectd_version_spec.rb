require 'spec_helper'

describe 'collectd_version', :type => :fact do
  before { Facter.clear }
  after { Facter.clear }

  it 'should be 5.1.0 according to output' do
    Facter::Util::Resolution.stubs(:which).with("collectd").returns("/usr/sbin/collectd")
    sample_collectd_help = File.read(fixtures('facts','collectd_help'))
    Facter::Util::Resolution.stubs(:exec).with("collectd -h").returns(sample_collectd_help)
    Facter.fact(:collectd_version).value.should == '5.1.0'
  end

  it 'should be 5.1.0.git according to output' do
    Facter::Util::Resolution.stubs(:which).with("collectd").returns("/usr/sbin/collectd")
    sample_collectd_help_git = File.read(fixtures('facts','collectd_help_git'))
    Facter::Util::Resolution.stubs(:exec).with("collectd -h").returns(sample_collectd_help_git)
    Facter.fact(:collectd_version).value.should == '5.1.0.git'
  end


end
