# frozen_string_literal: true

EsLogger.configure do |config|
  # Enable delayed process (using Sidekiq)
  # config.use_sidekiq
  # You can supply custom Sidekiq options:
  # config.use_sidekiq 'queue' => 'low'
  #
  # Set the pattern to allows save in Elasticsearch
  # Examples:
  # ^\/api\/external\/\w+ -> /api/external/v1, /api/external/v1/routes
  # config.include_pattern = [/^\/api\/external\/\w+/]

  # params configuration to connect with Elasticsearch
  config.elasticsearch = {
    user: ENV['ELASTICSEARCH_USER'] || 'elastic',
    password: ENV['ELASTICSEARCH_PASSWORD'] || '',
    host: ENV['ELASTICSEARCH_HOST'] || 'localhost',
    port: ENV['ELASTICSEARCH_PORT'] || 9200,
    log: ENV['ELASTICSEARCH_LOG'] || true
  }

  config.elasticsearch_index_name = ENV['ELASTICSEARCH_INDEX_NAME']
  config.elasticsearch_pool_connection = {
    size: ENV['ELASTICSEARCH_POOL_SIZE'] || 10,
    timeout: ENV['ELASTICSEARCH_TIMEOUT'] || 5
  }
end

EsLogger::Elasticsearch::ClientConnectionPool.instance.register_credentials
