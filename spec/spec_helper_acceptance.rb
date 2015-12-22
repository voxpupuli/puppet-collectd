require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'


if ! ENV["PUPPET_DEV_GIT"].nil?
  pr = ENV["PUPPET_DEV_GIT"]
  h = hosts[0]
  configure_foss_defaults_on(h)
  install_package h, 'git'
  if h['platform'] =~ /debian|ubuntu|cumulus/
    install_package h, 'ruby-dev'
    install_package h, 'bundler'
  else
    install_package h, 'ruby-devel'
    install_package h, 'rubygem-bundler'
  end
  on h, "git clone https://github.com/puppetlabs/hiera /tmp/hiera"
  on h, "sudo /tmp/hiera/install.rb --full"
  on h, "gem install facter"
  on h, "git clone https://github.com/puppetlabs/puppet /tmp/puppet"
  on h, "git --git-dir=/tmp/puppet/.git fetch origin pull/#{pr}/head:pr_#{pr}"
  on h, "git --git-dir=/tmp/puppet/.git checkout pr_#{pr}"
  on h, "cd /tmp/puppet; bundle install --path /tmp/puppet/.bundle/gems/"
  on h, "cd /tmp/puppet; bundle exec /tmp/puppet/install.rb --full"
else
  run_puppet_install_helper
end



on hosts[0], puppet('--version')
RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => 'collectd', :target_module_path => '/etc/puppetlabs/code/modules')
    hosts.each do |host|
      on host, puppet('module', 'install', 'puppetlabs-stdlib'), :acceptable_exit_codes => [0]
      on host, puppet('module', 'install', 'puppetlabs-concat'), :acceptable_exit_codes => [0]
    end
  end
end
