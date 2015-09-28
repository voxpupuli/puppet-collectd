require 'spec_helper'

describe 'test::collectd_version' do

 let :facts do
   {:osfamily => 'RedHat'}
 end

 it { should compile }

 context 'when no explicit value is specified' do
   it { should contain_file('collectd_version.tmp').with_content(/^1\.0$/) }
 end

 context 'when minimum_version is specified' do
   let :params do
     {
       :version         => 'installed',
       :minimum_version => '5.4',
     }
   end
   it { should contain_file('collectd_version.tmp').with_content(/^5\.4$/) }
 end

 context 'when version is explicit and greater than minimum_version' do
   let :params do
     {
       :version         => '5.6.3',
       :minimum_version => '5.4',
     }
   end
   it { should contain_file('collectd_version.tmp').with_content(/^5\.6\.3$/) }
 end

 context 'when version is explicit and less than minimum_version' do
   let :params do
     {
       :version         => '5.3',
       :minimum_version => '5.4',
     }
   end
   it { should contain_file('collectd_version.tmp').with_content(/^5\.3$/) }
 end

 context 'when collectd_real_version is available' do
   let :facts do
     {
       :osfamily              => 'Redhat',
       :collectd_real_version => '5.6',
     }
   end
   let :params do
     {
       :minimum_version => '5.4'
     }
   end
   it { should contain_file('collectd_version.tmp').with_content(/^5\.6$/) }
 end
end
