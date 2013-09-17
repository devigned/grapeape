require 'goliath/runner'
require 'grape_ape/goliath/server'

module GrapeApe
  module Goliath
    class Runner < ::Goliath::Runner

      # Sets up the Goliath server
      #
      # @param log [Logger] The logger to configure the server to log to
      # @return [Server] an instance of a Goliath server
      def setup_server(log = setup_logger)
        server = GrapeApe::Goliath::Server.new(@address, @port)
        server.logger = log
        server.app = @app
        server.api = @api
        server.plugins = @plugins || []
        server.options = @server_options
        server
      end

    end
  end
end