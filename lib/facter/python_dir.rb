# Fact: python_dir
#
# Purpose: Retrieve python package dir used by pip install
#
Facter.add(:python_dir) do
  setcode do
    if Facter::Util::Resolution.which('python')
      Facter::Util::Resolution.exec('python -c "import site; print(site.getsitepackages()[0])"')
    else
      ''
    end
  end
end
