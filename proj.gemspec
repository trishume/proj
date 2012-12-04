# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'proj/version'

Gem::Specification.new do |gem|
  gem.name          = "proj"
  gem.version       = Proj::VERSION
  gem.authors       = ["Tristan Hume"]
  gem.email         = ["trishume@gmail.com"]
  gem.description   = %q{A command-line tool for managing projects}
  gem.summary       = <<SUMMARY
`proj` is a command line tool for managing projects. 
It integrates with Git and Github to allow you to easily 
create new projects, run tasks and upload projects to Github.
SUMMARY
  gem.homepage      = "http://github.com/trishume/proj"

  gem.add_development_dependency 'rspec', '~> 2.5'
  gem.add_runtime_dependency 'commander','~> 4.1.2'
  gem.add_runtime_dependency 'grit', '~> 2.5.0'
  gem.add_runtime_dependency 'github_api'
  gem.add_runtime_dependency 'fuzzy_match'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
