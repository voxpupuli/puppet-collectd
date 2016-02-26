require 'spec_helper'

describe 'collectd::plugin::load', type: :class do
  let :pre_condition do
    'include ::collectd'
  end

  let :facts do
    { osfamily: 'Debian',
      collectd_version: '4.10.1'
    }
  end

  context 'report_relative in load.conf' do
    let :params do
      {
        report_relative: true
      }
    end

    it 'should be present' do
      should contain_file('load.load')
        .without_content(/\s{2}ReportRelative true\s{2}/)
    end
  end
end
