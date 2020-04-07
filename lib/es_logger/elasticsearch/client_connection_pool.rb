require 'singleton'
require 'connection_pool'
require 'es_logger/configuration'
require 'elasticsearch'

module EsLogger
  module Elasticsearch
    class ClientConnectionPool
      include Singleton
      attr_accessor :client

      def register_credentials
        puts 'Registering Elasticsearch Client'
        credentials = EsLogger.configuration.elasticsearch

        pool_size = EsLogger.configuration.elasticsearch_pool_size
        timeout = EsLogger.configuration.elasticsearch_timeout

        @client = ConnectionPool.new(size: pool_size, timeout: timeout) do
          ::Elasticsearch::Client.new(credentials)
        end
      end
    end
  end
end
