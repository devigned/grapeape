require 'eventmachine'

module GrapeApe
  module Goliath
    class Server < ::Goliath::Server
      def start(&blk)
        EM.epoll
        EM.synchrony do
          trap('INT') { stop }
          trap('TERM') { stop }

          if RUBY_PLATFORM !~ /mswin|mingw/
            trap('HUP') { load_config(options[:config]) }
          end

          load_config(options[:config])
          load_plugins
          setup_amqp

          EM.set_effective_user(options[:user]) if options[:user]

          config[::Goliath::Constants::GOLIATH_SIGNATURE] = EM.start_server(address, port, ::Goliath::Connection) do |conn|
            if options[:ssl]
              conn.start_tls(
                  :private_key_file => options[:ssl_key],
                  :cert_chain_file => options[:ssl_cert],
                  :verify_peer => options[:ssl_verify]
              )
            end

            conn.port = port
            conn.app = app
            conn.api = api
            conn.logger = logger
            conn.status = status
            conn.config = config
            conn.options = options
          end

          blk.call(self) if blk
        end
      end

      def stop
        logger.info('Stopping server...')
        config['grape_amqp_conn'].close { EM.stop }
      end

      def setup_amqp
        config['grape_amqp_conn'] = AMQP.connect(on_possible_authentication_failure: Proc.new { |settings|
          logger.info "Authentication failed, as expected, settings are: #{settings.inspect}"
          EM.stop
        })
        config['grape_amqp_channel'] = AMQP::Channel.new(config['grape_amqp_conn'])
        config['grape_amqp_exchange'] = config['grape_amqp_channel'].default_exchange
        config['grape_amqp_response_queue'] = SecureRandom.uuid
        config['grape_amqp_em_channel'] = EM::Channel.new

        q = config['grape_amqp_channel'].queue(config['grape_amqp_response_queue'], exclusive: true)

        q.subscribe do |meta, payload|
          config['grape_amqp_em_channel'].push({meta: meta, data: payload})
        end
      end
    end
  end
end