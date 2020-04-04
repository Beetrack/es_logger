RackEsLogger.configure do |config|
  # config.enabled = true
  # Enable delayed process (using Sidekiq)
  # config.use_sidekiq
  # You can supply custom Sidekiq options:
  # config.use_sidekiq 'queue' => 'low'
  # Configure elasticsearh client credentials
  # Config.elasticsearch = {
  #   user: '',
  #   password: '',
  #   host: '',
  #   port: 9200
  # }
end

RackEsLogger::Elasticsearch::Client.instance.register_credentials
