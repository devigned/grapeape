require 'grape_ape/consumer/application'

module GrapeApe
  class Worker
    class << self

      attr_reader :routing_key

      def routing_key(key)
        @routing_key = key
        Consumer::Application.register(key, self)
      end
    end

    def handle_message(metadata, payload)
      payload = JSON.parse(payload).with_indifferent_access
      response = if respond_to?(payload[:method].to_sym)
                   begin
                     ok(send(payload[:method].to_sym, payload[:params]))
                   rescue Exception => ex
                     error({message: ex.message, backtrace: ex.backtrace})
                   end
                 else
                   error("Worker listening to routing_key: #{self.routing_key} does not have method: #{payload[:method]}")
                 end
      Consumer::Application.amqp_channel.default_exchange.publish(response.to_json,
                                       routing_key: metadata.reply_to,
                                       correlation_id: metadata.correlation_id)
    end

    def ok(response)
      [:ok, response]
    end

    def error(response)
      [:error, response]
    end
  end
end