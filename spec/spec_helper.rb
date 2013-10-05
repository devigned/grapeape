$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'support'))

require 'coveralls'
Coveralls.wear!

require 'grape_ape'
require 'rubygems'
require 'bundler'
require 'rack/test'
require 'goliath/test_helper'
require 'evented-spec'
Bundler.setup :default, :test

Dir["#{File.dirname(__FILE__)}/support/*.rb"].each do |file|
  require file
end

RSpec.configure do |config|
  config.order = 'random'
  config.include Rack::Test::Methods
  config.include Goliath::TestHelper
end
