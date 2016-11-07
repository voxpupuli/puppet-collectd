Facter.add(:python_dir) do
  setcode do
    Facter::Util::Resolution.exec('python -c "import site; print site.getsitepackages()[0]"')
  end
end
