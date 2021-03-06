# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grape_ape/version'

Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'grapeape'
  s.version       = GrapeApe::VERSION
  s.authors       = ['David Justice']
  s.email         = %w(david@devigned.com)
  s.description   = 'Message based, event driven web dsl in ruby'
  s.summary       = <<-MSG
Message based, event driven web dsl in ruby. The project stands up an event driven web (goliath / grape) dsl backed by
AMQP. AMQP is used to route messages from the web to a collection of event driven worker processes in an RPC flow.

This could be used to set up a quick [CQRS](http://martinfowler.com/bliki/CQRS.html) architecture.
  MSG
  s.homepage      = ''
  s.license       = 'MIT'
  s.required_ruby_version = '>= 2.0.0'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = %w(lib)

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'em-http-request'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'evented-spec'

  s.add_dependency 'goliath'
  s.add_dependency 'grape'
  s.add_dependency 'amqp'
  s.add_dependency 'activesupport'
end
