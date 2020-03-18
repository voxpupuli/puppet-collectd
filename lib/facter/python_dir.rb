# Fact: python_dir
#
# Purpose: Retrieve python package dir used by pip install
#
Facter.add(:python_dir) do
  setcode do
    if Facter::Util::Resolution.which('python')
      if Facter.value(:osfamily) == 'RedHat'
        Facter::Util::Resolution.exec('python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"')
      else
        Facter::Util::Resolution.exec('python -c "import site; print(site.getsitepackages()[0])"')
      end
    elsif Facter::Util::Resolution.which('python3')
      if Facter.value(:osfamily) == 'RedHat'
        Facter::Util::Resolution.exec('python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"')
      else
        Facter::Util::Resolution.exec('python3 -c "import site; print(site.getsitepackages()[0])"')
      end
    elsif File.exist?('/usr/libexec/platform-python')
      Facter::Util::Resolution.exec('/usr/libexec/platform-python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"')
    else
      ''
    end
  end
end
