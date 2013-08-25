require 'spec_helper'

describe 'collectd' do

 let :facts do
   {:osfamily => 'RedHat'}
 end

 it { should contain_package('collectd').with(
   :ensure => 'installed'
 )}

 it { should contain_service('collectd').with(
   :ensure => 'running'
 )}

 it { should contain_file('collectd.conf') }

 it { should contain_file('collectd.d').with(
  :ensure => 'directory'
 )}

 context 'on non supported opearting systems' do
   let :facts do
     {:osfamily => 'foo'}
   end

   it 'should fail' do
     expect { subject }.to  raise_error(/foo is not supported/)
   end
 end

end
