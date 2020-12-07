# frozen_string_literal: true

module EsLogger
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :jwt,
                  :async_handler,
                  :include_pattern,
                  :elasticsearch,
                  :elasticsearch_index_name,
                  :elasticsearch_pool_connection

    def initialize
      @jwt = nil
      @async_handler = nil
      @include_pattern = nil
      @elasticsearch = {}
      @elasticsearch_index_name = 'request'
      @elasticsearch_pool_connection = { size: 10, timeout: 5 }
    end

    def use_sidekiq(options = {})
      require 'es_logger/delay/sidekiq'
      @async_handler = EsLogger::Delay::Sidekiq.new(options)
    end
  end
end
