lib = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

module Microbe
  autoload :Application, 'microbe/application'
  autoload :Endpoint, 'microbe/endpoint'
  autoload :Resource, 'microbe/resource'
  autoload :Utils, 'microbe/utils'
  autoload :Dispatcher, 'microbe/dispatcher'
  autoload :Configuration, 'microbe/configuration'
end
