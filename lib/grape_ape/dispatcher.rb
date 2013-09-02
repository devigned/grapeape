module GrapeApe
  module Dispatcher
    def rpc(env, queue_name, message = {})
      f = Fiber.current
      response = nil
      env['subscription'] = env.channel.subscribe do |msg|
        if msg[:meta].correlation_id == env['correlation_id']
          response = msg[:data]
          f.resume
        end
      end

      env['correlation_id'] = SecureRandom.uuid
      env.xchange.publish(message.to_json,
                          routing_key: queue_name,
                          reply_to: env.response_queue_name,
                          correlation_id: env['correlation_id'])
      Fiber.yield
      JSON.parse(response)
    end
  end
end