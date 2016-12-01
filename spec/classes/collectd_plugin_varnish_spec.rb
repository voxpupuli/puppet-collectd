require 'spec_helper'

describe 'collectd::plugin::varnish', type: :class do
  let :pre_condition do
    'include ::collectd'
  end

  context 'When the version is not 5.4' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.3',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      {}
    end
    it 'renders the template with the default values' do
      content = <<EOS
<Plugin varnish>
  <Instance "localhost">
  </Instance>
</Plugin>
EOS
      is_expected.to contain_collectd__plugin('varnish').with_content(content)
    end
  end
  context 'When the version is nil' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: nil,
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      {}
    end
    it 'renders the template with the default values' do
      content = <<EOS
<Plugin varnish>
  <Instance "localhost">
  </Instance>
</Plugin>
EOS
      is_expected.to contain_collectd__plugin('varnish').with_content(content)
    end
  end

  context 'When the version is 5.4' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    context 'when there are no params given' do
      let :params do
        {}
      end
      it 'renders the template with the default values' do
        content = <<EOS
<Plugin varnish>
  <Instance "localhost">
  </Instance>
</Plugin>
EOS
        is_expected.to contain_collectd__plugin('varnish').with_content(content)
      end
    end
    context 'when there are params given' do
      let :params do
        {
          'instances' => {
            'warble' => {
              'BATMAN' => true,
              'Robin' => false
            }
          }
        }
      end
      it 'renders the template with the values passed in the params' do
        content = <<EOS
<Plugin varnish>
  <Instance "warble">
    BATMAN true
    Robin false
  </Instance>
</Plugin>
EOS
        is_expected.to contain_collectd__plugin('varnish').with_content(content)
      end
    end
  end
end
