require 'hashie'
require 'active_support/json'
require 'active_support/core_ext/hash/indifferent_access'
require 'grape'
require 'grape_ape/version'
require 'amqp'

module GrapeApe
  autoload :API,            'grape_ape/api'
  autoload :Dispatcher,     'grape_ape/dispatcher'
  autoload :Endpoint,       'grape_ape/endpoint'
  autoload :Worker,         'grape_ape/worker'
  autoload :Server,         'grape_ape/server'
end

