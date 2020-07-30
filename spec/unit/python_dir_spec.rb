require 'spec_helper'

describe 'python_dir', type: :fact do
  before { Facter.clear }

  describe 'python dir' do
    context 'default path' do
      before do
        # This is needed to make this spec work on Fedora, apparently
        allow(Facter).to receive(:value).with(:osfamily).and_return('AnythingNotRedHat')
        allow(Facter::Util::Resolution).to receive(:which).with('python').and_return(true)
        allow(Facter::Util::Resolution).to receive(:exec).with('python -c "import site; print(site.getsitepackages()[0])"').and_return('/usr/local/lib/python2.7/dist-packages')
      end
      it do
        expect(Facter.fact(:python_dir).value).to eq('/usr/local/lib/python2.7/dist-packages')
      end
    end

    context 'RedHat' do
      before do
        allow(Facter).to receive(:value).with(:osfamily).and_return('RedHat')
        allow(Facter::Util::Resolution).to receive(:which).with('python').and_return(true)
        allow(Facter::Util::Resolution).to receive(:exec).with('python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"').and_return('/usr/lib/python2.7/site-packages')
      end
      it do
        expect(Facter.fact(:python_dir).value).to eq('/usr/lib/python2.7/site-packages')
      end
    end

    context 'RedHat versioned python' do
      before do
        allow(Facter).to receive(:value).with(:osfamily).and_return('RedHat')
        allow(Facter::Util::Resolution).to receive(:which).with('python').and_return(false)
        allow(Facter::Util::Resolution).to receive(:which).with('python3').and_return(true)
        allow(Facter::Util::Resolution).to receive(:exec).with('python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"').and_return('/usr/lib/python3.6/site-packages')
      end
      it do
        expect(Facter.fact(:python_dir).value).to eq('/usr/lib/python3.6/site-packages')
      end
    end
  end

  it 'is empty string if python not installed' do
    allow(Facter::Util::Resolution).to receive(:which).with('python').and_return(nil)
    allow(Facter::Util::Resolution).to receive(:which).with('python2').and_return(nil)
    allow(Facter::Util::Resolution).to receive(:which).with('python3').and_return(nil)
    allow(File).to receive(:exist?).with('/usr/libexec/platform-python').and_return(nil)
    expect(Facter.fact(:python_dir).value).to eq('')
  end
end
