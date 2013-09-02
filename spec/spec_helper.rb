$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'support'))

require 'grape_ape'

# require 'grape-entity'

require 'rubygems'
require 'bundler'
require 'rack/test'
Bundler.setup :default, :test

Dir["#{File.dirname(__FILE__)}/support/*.rb"].each do |file|
  require file
end

RSpec.configure do |config|
  config.order = 'random'
  config.include Rack::Test::Methods
end