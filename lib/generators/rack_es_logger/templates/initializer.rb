RackEsLogger.configure do |config|
  # Enable delayed process (using Sidekiq)
  # config.use_sidekiq
  # You can supply custom Sidekiq options:
  # config.use_sidekiq 'queue' => 'low'
end
