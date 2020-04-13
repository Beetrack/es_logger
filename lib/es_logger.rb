require 'es_logger/version'
require 'es_logger/response'
require 'es_logger/configuration'
require 'es_logger/elasticsearch/client_connection_pool'

module EsLogger
  class Rack
    attr_reader :response

    def initialize(app)
      @app = app
      @response = {}
    end

    def call(env)
      @response = EsLogger::Response.new(env).call

      send_request

      @app.call(env)
    end

    def send_request
      return if EsLogger.configuration.include_pattern.find { |route| @response[:path].match?(route) }.nil?

      return if @response[:path] == '/cable'

      @response[:timestamp] = Time.now.utc

      client.index index: EsLogger.configuration.elasticsearch_index_name, body: @response
    rescue ::Elasticsearch::Transport::Transport::Errors::ServiceUnavailable
      puts 'Cannot connect with Elastisearch service'
    end

    private

    def client
      ::EsLogger::Elasticsearch::ClientConnectionPool.instance.client.with { |client| client }
    end
  end
end
