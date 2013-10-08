# GrapeApe

[![Code Climate](https://codeclimate.com/github/devigned/grapeape.png)](https://codeclimate.com/github/devigned/grapeape)
[![Build Status](https://travis-ci.org/devigned/grapeape.png)](https://travis-ci.org/devigned/grapeape)
[![Coverage Status](https://coveralls.io/repos/devigned/grapeape/badge.png?branch=master)](https://coveralls.io/r/devigned/grapeape?branch=master)
[![Dependency Status](https://gemnasium.com/devigned/grapeape.png)](https://gemnasium.com/devigned/grapeape)

Eventmachine driven distributed web API in ruby. The project stands up an event driven web API
([goliath](http://postrank-labs.github.io/goliath/) / [grape](http://intridea.github.io/grape/)) backed by
[AMQP](http://www.amqp.org/). AMQP is used to route messages from the web to a collection of event driven worker
processes in an RPC flow.

Note: this is not ready for primetime

## Installation

Add this line to your application's Gemfile:

    gem 'grapeape'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grapeape

## Usage

Usage instructions are upcoming. For usage examples, please see our [examples](examples).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
