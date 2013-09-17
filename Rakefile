require 'bundler/gem_tasks'
require 'rubygems'
require 'rake'

def safe_load
  begin
    yield
  rescue LoadError => ex
    puts 'Error loading rake tasks, but will continue...'
    puts ex.message
  end
end

safe_load do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
end

task :default => [:spec]