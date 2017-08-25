module Microbe
  class Configuration
    def initialize(app)
      @app = app
    end

    def dispatcher
      @_dispatcher
    end

    def dispatcher=(instance)
      @_dispatcher = instance
    end

    def middlewares
      @_middlewares ||= []
    end

    def load!
      load app.config_path.join("environments", "#{app.env}.rb")
      load app.config_path.join("mounts.rb")
    end

    private

    attr_reader :app
  end
end
