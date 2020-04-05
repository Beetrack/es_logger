require 'es_logger/configuration'
require 'es_logger/elasticsearch/request'
require 'elasticsearch/persistence'

module EsLogger
  module Elasticsearch
    class RequestRepository
      include ::Elasticsearch::Persistence::Repository
      include ::Elasticsearch::Persistence::Repository::DSL

      client EsLogger::Elasticsearch::ClientConnectionPool.instance.client.with { |client| client }

      index_name EsLogger.configuration.elasticsearch_index_name
      klass EsLogger::Elasticsearch::Request
    end
  end
end
