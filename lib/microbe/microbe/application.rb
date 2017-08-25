module Microbe
  class Application
    def call(env)
      request = Rack::Request.new(env)
      dispatcher.call(request)
    end

    def dispatcher
      self.class.dispatcher
    end

    def self.dispatcher
      config.dispatcher
    end

    def self.root
      Pathname.new(Dir.pwd)
    end

    def self.config_path
      root.join('config')
    end

    def self.config
      @_config ||= Configuration.new(self)
    end

    def self.configure
      yield config
    end

    def self.mounts
      yield dispatcher
    end

    def self.env
      @_env ||= (ENV['MICROBE_ENV'] || ENV['RACK_ENV'] || 'development').to_sym
    end

    def self.env=(value)
      @_env = value
    end

    def self.instance
      @_instance ||= begin
        config = self.config
        config.load!
        inst = self.new
        app = Rack::Builder.new do
          config.middlewares.each { |middleware| use middleware }
          run inst
        end
      end
    end
  end
end
