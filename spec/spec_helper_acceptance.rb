require 'beaker-rspec'
require 'beaker-puppet'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'

RSpec.configure do |c|
  install_module_on(hosts)
  install_module_dependencies_on(hosts)

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      # python is pre-requisite to the python_path fact.
      on host, puppet('resource', 'package', 'python', 'ensure=installed')
    end
  end
end
