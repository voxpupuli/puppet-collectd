require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'metadata-json-lint/rake_task'

PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_class_parameter_defaults')
PuppetLint.configuration.send('disable_documentation')

# These two gems aren't always present, for instance
# on Travis with --without development
begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
end

exclude_paths = [
  "pkg/**/*",
  "vendor/**/*",
  "spec/**/*",
]
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetSyntax.exclude_paths = exclude_paths

desc "Run acceptance tests"
RSpec::Core::RakeTask.new(:acceptance) do |t|
  t.pattern = 'spec/acceptance'
end

desc "Run metadata_lint, lint, syntax, and spec tests."
task :test => [
  :metadata_lint,
  :lint,
  :syntax,
  :spec,
]

if RUBY_VERSION >= "1.9.0" and RUBY_VERSION < "2.2.0" then
  Blacksmith::RakeTask.new do |t|
    t.build = false # do not build the module nor push it to the Forge
    # just do the tagging [:clean, :tag, :bump_commit]
  end


  desc "Offload release process to Travis."
  task :travis_release => [
    :check_changelog,  # check that the changelog contains an entry for the current release
    :"module:release", # do everything except build / push to forge, travis will do that for us
  ]

  desc "Check Changelog."
  task :check_changelog do
    v = Blacksmith::Modulefile.new.version
    if File.readlines('CHANGELOG.md').grep("Releasing #{v}").size == 0 then
      fail "Unable to find a CHANGELOG.md entry for the #{v} release."
    end
  end
end
