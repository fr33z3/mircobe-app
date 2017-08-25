module Microbe
  class Dispatcher
    def initialize
      @routes = []
    end

    def mount(resource_class)
      resource_class.actions.each do |(_, action)|
        regex = case action[:type]
        when :collection then collection_regex(resource_class, action[:name])
        when :member then member_regex(resource_class, action[:name])
        end

        routes << {
          regex: regex,
          resource: resource_class,
          action: action[:name]
        }
      end
    end

    def call(request)
      regex_match = nil
      route = routes.find do |route|
        regex_match = route[:regex].match(request.path)
      end
      binding.pry

      response = Rack::Response.new
      if route
        regex_match.names.each do |name|
          request.params[name] = regex_match[name]
        end
        UserResource.new(request, response).call(route[:action])
      else
        response.status = 404
      end

      response
    end

    private

    attr_reader :routes

    def collection_regex(resource_class, action_name)
      underscored = Utils::String.new(resource_class.name).underscore
      resource_uri_name = Utils::String.new(underscored.gsub(/_resource$/, '')).pluralize
      /^\/#{resource_uri_name}\/#{action_name}\/?$/
    end

    def member_regex(resource_class, action_name)
      underscored = Utils::String.new(resource_class.name).underscore
      resource_uri_name = underscored.gsub(/_resource$/, '')
      /^\/#{resource_uri_name}\/(?<id>[a-zA-Z0-9_-]+)\/#{action_name}\/?$/
    end
  end
end
