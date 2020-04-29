# frozen_string_literal: true

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
      worker = EsLogger.configuration.async_handler

      if included_path?(env['PATH_INFO'])
        @response = EsLogger::Response.call(env)
        puts @response.inspect
        !worker.nil? ? worker.call(response) : EsLogger::Request.call(response)
        @processed = true
      else
        @processed = false
      end

      @app.call(env)
    end

    private

    def included_path?(path)
      include_pattern = EsLogger.configuration.include_pattern

      return true if include_pattern.nil?

      !include_pattern.find { |route| path.match?(route) }.nil?
    end
  end
end
