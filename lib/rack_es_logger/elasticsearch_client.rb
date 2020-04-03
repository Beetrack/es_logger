require 'singleton'
require 'connection_pool'
require 'rack_es_logger/configuration'

module RackEsLogger
  class ElasticsearchClient
    include Singleton
    attr_accessor :client

    def register_credentials
      credentials = RackEsLogger.configuration.elasticsearch

      @client = ConnectionPool.new do
        Elasticsearch::Client.new(credentials.merge(log: true))
      end
    end
  end
end
