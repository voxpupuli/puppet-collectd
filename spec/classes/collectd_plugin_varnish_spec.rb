require 'spec_helper'

describe 'collectd::plugin::varnish', :type => :class do

  context 'When the version is 5.4' do
    let :facts do
      { :osfamily => 'RedHat',
        :collectd_version => '5.4',
      }
    end
    context 'when there are no params given' do
      let :params do
        {}
      end
      it 'should render the template with the default values' do
content = <<EOS
<Plugin varnish>
  <Instance "localhost">
    CollectCache true
    CollectBackend true
    CollectConnections true
    CollectSHM true
    CollectESI false
    CollectFetch true
    CollectHCB false
    CollectTotals true
    CollectWorkers true
  </Instance>
</Plugin>
EOS
        should contain_collectd__plugin('varnish').with_content(content)
      end
    end
  end


end
