require 'spec_helper'

describe 'collectd::plugin::load', type: :class do
  let :pre_condition do
    'include ::collectd'
  end

  let :facts do
    {
      osfamily: 'Debian',
      collectd_version: '4.10.1',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context 'report_relative in load.conf' do
    let :params do
      {
        report_relative: true
      }
    end

    it 'is present' do
      is_expected.to contain_file('load.load').
        without_content(%r{\s{2}ReportRelative true\s{2}})
    end
  end
end
