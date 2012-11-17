require "bundler/gem_tasks"

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')

task :projnew do |t,args|
  ruby '-Ilib','./bin/proj', 'new', 'testProj'
end

task :default=>:spec
