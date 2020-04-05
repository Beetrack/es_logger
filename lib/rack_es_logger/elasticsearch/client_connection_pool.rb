require 'singleton'
require 'connection_pool'
require 'rack_es_logger/configuration'

module RackEsLogger
  module Elasticsearch
    class ClientConnectionPool
      include Singleton
      attr_accessor :client

      def register_credentials
        puts '::Registering Elasticsearch Client'
        credentials = RackEsLogger.configuration.elasticsearch

        pool_size = RackEsLogger.configuration.elasticsearch_pool_size
        timeout = RackEsLogger.configuration.elasticsearch_timeout

        @client = ConnectionPool.new(size: pool_size, timeout: timeout) do
          Elasticsearch::Client.new(credentials)
        end
      end
    end
  end
end
