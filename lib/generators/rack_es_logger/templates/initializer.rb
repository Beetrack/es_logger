RackEsLogger.configure do |config|
  # config.enabled = true
  # Enable delayed process (using Sidekiq)
  # config.use_sidekiq
  # You can supply custom Sidekiq options:
  # config.use_sidekiq 'queue' => 'low'
  #
  # params configuration to connect with Elasticsearch
  config.elasticsearch = {
    user: ENV['ELASTICSEARCH_USER'],
    password: ENV['ELASTICSEARCH_PASSWORD'],
    host: ENV['ELASTICSEARCH_HOST'],
    port: ENV['ELASTICSEARCH_PORT']
  }

  config.elasticsearch_index_name = ENV['ELASTICSEARCH_INDEX_NAME']

  config.elasticsearch_pool_size = ENV['ELASTICSEARCH_POOL_SIZE'] || 10
  config.elasticsearch_timeout = ENV['ELASTICSEARCH_TIMEOUT'] || 5
end

RackEsLogger::Elasticsearch::Client.instance.register_credentials
