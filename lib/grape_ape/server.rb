require 'goliath'
require 'goliath/websocket'

module GrapeApe
  class Server < Goliath::API
    def initialize(opts = {})
      @api = opts.delete(:api)
    end

    def response(env)
      @api.call(env)
    end
  end
end