require 'goliath/test_helper'

module GrapeApe
  module TestHelper
    include Goliath::TestHelper

    # Wrapper for launching API and executing given code block. This
    # will start the EventMachine reactor running.
    #
    # @param api [Class] The GrapeApe::API class to launch
    # @param options [Hash] The options to pass to the server
    # @param blk [Proc] The code to execute after the server is launched.
    # @note This will not return until stop is called.
    def with_api(api, options = {}, &blk)
      server(GrapeApe::Server.new(api: api), options.delete(:port) || 9900, options, &blk)
    end

    # Launches an instance of a given API server. The server
    # will launch on the specified port.
    #
    # @param api [Class] The API class to launch
    # @param port [Integer] The port to run the server on
    # @param options [Hash] The options hash to provide to the server
    # @return [Goliath::Server] The executed server
    def server(api, port, options = {}, &blk)
      op = OptionParser.new

      s = Goliath::Server.new
      s.logger = setup_logger(options)
      s.api = api
      s.app = Goliath::Rack::Builder.build(api.class, s.api)
      s.api.options_parser(op, options)
      s.options = options
      s.port = port
      s.plugins = api.class.plugins
      @test_server_port = s.port if blk
      s.start(&blk)
      s
    end
  end
end