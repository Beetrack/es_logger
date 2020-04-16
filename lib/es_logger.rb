require 'es_logger/version'
require 'es_logger/response'
require 'es_logger/configuration'
require 'es_logger/request'

module EsLogger
  class Rack
    attr_reader :response

    def initialize(app)
      @app = app
      @response = {}
    end

    def call(env)
      @response = EsLogger::Response.call(env)

      if !(worker = EsLogger.configuration.async_handler).nil?
        worker.call(@response)
      else
        EsLogger::Request.call(@response)
      end

      @app.call(env)
    end

    def valid_path?
      @response[:path] != '/cable' || !EsLogger.configuration.include_pattern.find { |route| @response[:path].match?(route) }.nil?
    end
  end
end
