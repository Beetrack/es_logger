module EsLogger
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :include_pattern
    attr_accessor :elasticsearch
    attr_accessor :elasticsearch_index_name
    attr_accessor :elasticsearch_pool_connection

    def initialize
      @include_pattern = nil
      @elasticsearch = { host: 'localhost', port: 9200, user: 'elastic', password: nil, log: true }
      @elasticsearch_index_name = 'request'
      @elasticsearch_pool_connection = { size: 10, timeout: 5 }
    end
  end
end
