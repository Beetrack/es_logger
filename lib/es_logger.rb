require 'es_logger/version'
require 'es_logger/response'
require 'es_logger/configuration'
require 'es_logger/request'

module EsLogger
  class Rack
    attr_reader :response, :processed

    def initialize(app)
      @app = app
      @response = {}
      @processed = false
    end

    def call(env)
      @response = EsLogger::Response.call(env)

      worker = EsLogger.configuration.async_handler

      if valid_path?
        !worker.nil? ? worker.call(response) : EsLogger::Request.call(response)
        @processed = true
      else
        @processed = false
      end

      @app.call(env)
    end

    def valid_path?
      @response['path'] != '/cable' || !EsLogger.configuration.include_pattern.find { |route| @response['path'].match?(route) }.nil?
    end
  end
end
