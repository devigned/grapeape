require 'hashie'
require 'active_support/core_ext/hash/indifferent_access'
require 'grape'
require 'grape_ape/version'
require 'grape_ape/goliath_runner'

module GrapeApe
  autoload :API,            'grape_ape/api'
  autoload :Dispatcher,     'grape_ape/dispatcher'
  autoload :Endpoint,       'grape_ape/endpoint'
end

