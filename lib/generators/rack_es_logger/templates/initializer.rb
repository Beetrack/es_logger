RackEsLogger.configure do |config|
  # config.enabled = true
  # Enable delayed process (using Sidekiq)
  # config.use_sidekiq
  # You can supply custom Sidekiq options:
  # config.use_sidekiq 'queue' => 'low'
  #
  config.elasticsearch = {
    user: ENV['ELASTICSEARCH_USER'],
    password: ENV['ELASTICSEARCH_PASSWORD'],
    host: ENV['ELASTICSEARCH_HOST'],
    port: ENV['ELASTICSEARCH_PORT']
  }

  config.elasticsearch_pool_size = ENV['ELASTICSEARCH_POOL_SIZE'] || 10
  config.elasticsearch_timeout = ENV['ELASTICSEARCH_TIMEOUT'] || 5
end

RackEsLogger::Elasticsearch::Client.instance.register_credentials
