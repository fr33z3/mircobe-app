require 'rubygems'
require 'bundler'
Bundler.require(:default, :development)

require 'lib/microbe/microbe'

Dir[File.expand_path('../app/**/*.rb', __FILE__)].each do |file|
  require file
end

module MicrobeApp
  class Application < ::Microbe::Application
    # def self.call(env)
    #   binding.pry
    #   super
    # end
  end
end
