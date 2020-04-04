require 'rack_es_logger/version'
require 'rack_es_logger/response'
require 'rack_es_logger/configuration'
require 'rack_es_logger/elasticsearch/client'

module RackEsLogger
  class Application
    attr_reader :payload

    def initialize(app)
      @app = app
    end

    def call(env)
      response = RackEsLogger::Response.new(env)
      @payload = response.call
      @app.call(env)
    end
  end
end
