# frozen_string_literal: true

require 'es_logger/configuration'
require 'es_logger/elasticsearch/client_connection_pool'

module EsLogger
  class Request
    def self.call(response)
      response['timestamp'] = Time.now.utc

      client = ::EsLogger::Elasticsearch::ClientConnectionPool.instance.client.with { |c| c }
      client.index index: EsLogger.configuration.elasticsearch_index_name, body: response

      response
    rescue ::Elasticsearch::Transport::Transport::Errors::ServiceUnavailable, ::Faraday::ConnectionFailed
      puts 'Cannot connect with Elastisearch service'
    end
  end
end
