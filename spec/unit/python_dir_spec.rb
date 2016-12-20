require 'spec_helper'

describe 'python_dir', type: :fact do
  before { Facter.clear }

  describe 'python dir' do
    context 'default path' do
      before do
        Facter::Util::Resolution.stubs(:which).with('python').returns(true)
        Facter::Util::Resolution.stubs(:exec).with('python -c "import site; print(site.getsitepackages()[0])"').returns('/usr/local/lib/python2.7/dist-packages')
      end
      it do
        expect(Facter.value(:python_dir)).to eq('/usr/local/lib/python2.7/dist-packages')
      end
    end

    context 'RedHat' do
      before do
        Facter.fact(:osfamily).stubs(:value).returns('RedHat')
        Facter::Util::Resolution.stubs(:which).with('python').returns(true)
        Facter::Util::Resolution.stubs(:exec).with('python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"').returns('/usr/lib/python2.7/site-packages')
      end
      it do
        expect(Facter.value(:python_dir)).to eq('/usr/lib/python2.7/site-packages')
      end
    end
  end

  it 'is empty string if python not installed' do
    Facter::Util::Resolution.stubs(:which).with('python').returns(nil)
    expect(Facter.fact(:python_dir).value).to eq('')
  end
end
