# GrapeApe

[![Code Climate](https://codeclimate.com/github/devigned/grapeape.png)](https://codeclimate.com/github/devigned/grapeape)

Message based, event driven web dsl in ruby. The project stands up an event driven web (goliath / grape) dsl backed by
AMQP. AMQP is used to route messages from the web to a collection of event driven worker processes in an RPC flow.

This could be used to set up a quick [CQRS](http://martinfowler.com/bliki/CQRS.html) architecture.

## This is completely WIP, and will be changing rapidly....

## Installation

Add this line to your application's Gemfile:

    gem 'grapeape'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grapeape

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
