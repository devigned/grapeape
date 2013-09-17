require 'active_support/core_ext/class/attribute'
require 'grape_ape/goliath/application_patch'

module GrapeApe
  class API < Grape::API
    REQUIRED_ROUTE_KEYS = [:routing_key, :method]

    cattr_accessor :app_class

    class << self
      def inherited(subclass)
        super
        GrapeApe::API.app_class = subclass.name if defined?(GrapeApe::API)
      end

      def route(methods, paths = %w(/), route_options = {}, &block)
        if ape_route?(route_options)
          endpoint_options = {
              :method => methods,
              :path => paths,
              :route_options => (@namespace_description || {}).deep_merge(@last_description || {}).deep_merge(route_options || {})
          }

          endpoints << GrapeApe::Endpoint.new(settings.clone, endpoint_options) do
            message = rpc(env, route_options[:routing_key], {method: route_options[:method], params: params})
            if block
              block.call(message)
            else
              message
            end
          end

          @last_description = nil
          reset_validations!
        else
          super
        end
      end

      private

      def ape_route?(route_options)
        keys = Set.new(route_options.keys)
        Set[*REQUIRED_ROUTE_KEYS].subset?(keys)
      end
    end
  end
end