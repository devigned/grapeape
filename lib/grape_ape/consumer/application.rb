require 'active_support/core_ext/class/attribute'
require 'eventmachine'
require 'em-synchrony'
require 'amqp'

module GrapeApe
  module Consumer
    module Application

      module_function

      def amqp_channel
        @channel
      end

      def register(routing_key, klass)
        @keys_and_klasses ||= {}
        @keys_and_klasses[routing_key] = klass
      end

      def run!
        start do
          connect
        end
      end

      def connect
        AMQP.connect do |connection|
          @channel = AMQP::Channel.new(connection)

          @keys_and_klasses.each do |key, value|
            q = @channel.queue(key, :auto_delete => true)
            q.subscribe do |metadata, payload|
              value.new.handle_message(metadata, payload)
            end
          end
        end
      end

      # Stops the consumer running.
      def stop
        logger.info('Stopping the consumers...')
        EM.stop
      end

      def start
        EM.epoll
        EM.synchrony do
          trap('INT') { stop }
          trap('TERM') { stop }
          yield if block_given?
        end
      end

      at_exit do
        # Only run the application if ...
        #  - we want it to run
        #  - there has been no exception raised
        #  - the file that has been run, is the goliath application file
        if $!.nil?
          Application.run!
        end
      end
    end
  end
end