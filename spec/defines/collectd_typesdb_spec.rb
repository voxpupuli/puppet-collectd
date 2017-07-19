require 'spec_helper'

describe 'collectd::typesdb', type: :define do
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      let :facts do
        facts
      end

      context 'without any types' do
        let(:title) { '/etc/collectd/types.db' }

        it 'contains empty types.db' do
          is_expected.to contain_concat('/etc/collectd/types.db').with(
            ensure: 'present',
            path: '/etc/collectd/types.db'
          ).with_mode('0640')
        end
      end

      context 'with a different file mode' do
        let(:title) { '/etc/collectd/types.db' }
        let(:params) { { 'mode' => '0644' } }

        it 'contains file with different mode' do
          is_expected.to contain_concat('/etc/collectd/types.db').with(
            ensure: 'present',
            path: '/etc/collectd/types.db'
          ).with_mode('0644')
        end
      end
    end
  end
end
