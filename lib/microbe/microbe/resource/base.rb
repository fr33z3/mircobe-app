module Microbe
  module Resource
    class Base
      extend Forwardable

      def initialize(request, response)
        @request = request
        @response = response
      end

      def call(action_name)
        result = instance_eval &actions[action_name][:block]
        response.write(result)
      end

      def self.action(name, type, options, &block)
        actions[name.to_sym] = {
          name: name,
          type: type,
          options: options,
          block: block
        }
      end

      def self.collection(name, options={}, &block)
        action(name, :collection, options, &block)
      end

      def self.member(name, options={}, &block)
        action(name, :member, options, &block)
      end

      def self.actions
        @_actions ||= {}
      end

      private

      attr_reader :request, :response

      def_delegators :@request, :params

      def actions
        self.class.actions
      end

    end
  end
end
