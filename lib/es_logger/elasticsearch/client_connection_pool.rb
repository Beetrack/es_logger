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

        pool_connection = EsLogger.configuration.elasticsearch_pool_connection

        @client = ConnectionPool.new(pool_connection) do
          ::Elasticsearch::Client.new(credentials)
        end
      end
    end
  end
end
