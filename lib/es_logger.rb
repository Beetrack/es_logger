require 'es_logger/version'
require 'es_logger/response'
require 'es_logger/configuration'
require 'es_logger/elasticsearch/client_connection_pool'

module EsLogger
  class Rack
    attr_reader :payload

    def initialize(app)
      @app = app
    end

    def call(env)
      response = EsLogger::Response.new(env).call
      response[:timestamp] = Time.now.utc

      client.index index: EsLogger.configuration.elasticsearch_index_name, body: response

      @app.call(env)
    end

    def client
      ::EsLogger::Elasticsearch::ClientConnectionPool.instance.client.with { |client| client }
    end
  end
end
