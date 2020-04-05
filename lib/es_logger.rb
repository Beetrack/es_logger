require 'es_logger/version'
require 'es_logger/response'
require 'es_logger/configuration'
require 'es_logger/elasticsearch/client_connection_pool'

module EsLogger
  class Application
    attr_reader :payload

    def initialize(app)
      @app = app
    end

    def call(env)
      response = EsLogger::Response.new(env)
      @payload = response.call
      @app.call(env)
    end
  end
end
