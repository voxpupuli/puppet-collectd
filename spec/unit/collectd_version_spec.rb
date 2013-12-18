require 'spec_helper'

describe 'collectd_version', :type => :fact do

  it 'should be 5.1.0 according to output' do
    Facter::Util::Resolution.stubs(:which).with("collectd").returns("/usr/sbin/collectd")
    sample_collectd_help = File.read(fixtures('facts','collectd_help'))
    Facter::Util::Resolution.stubs(:exec).with("collectd -h").returns(sample_collectd_help)
    Facter.fact(:collectd_version).value.should == '5.1.0'
  end

end
