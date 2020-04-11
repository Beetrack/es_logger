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
      @elasticsearch = nil
      @elasticsearch_index_name = nil
      @elasticsearch_pool_connection = { pool: 10, timeout: 5 }
    end
  end
end
