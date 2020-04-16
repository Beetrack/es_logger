require 'es_logger/configuration'
require 'es_logger/elasticsearch/client_connection_pool'

module EsLogger
  class Request
    def self.call(response)
      response['timestamp'] = Time.now.utc

      client.index index: EsLogger.configuration.elasticsearch_index_name, body: response
    rescue ::Elasticsearch::Transport::Transport::Errors::ServiceUnavailable
      puts 'Cannot connect with Elastisearch service'
    end

    private

    def client
      ::EsLogger::Elasticsearch::ClientConnectionPool.instance.client.with { |client| client }
    end
  end
end
