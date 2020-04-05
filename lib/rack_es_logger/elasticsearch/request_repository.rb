require 'rack_es_logger/configuration'
require 'rack_es_logger/elasticsearch/request'
require 'elasticsearch/persistence'

module RackEsLogger
  module Elasticsearch
    class RequestRepository
      include ::Elasticsearch::Persistence::Repository
      include ::Elasticsearch::Persistence::Repository::DSL

      client RackEsLogger::Elasticsearch::ClientConnectionPool.instance.client.with { |client| client }

      index_name RackEsLogger.configuration.elasticsearch_index_name
      klass RackEsLogger::Elasticsearch::Request
    end
  end
end
