module EsLogger
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :elasticsearch
    attr_accessor :elasticsearch_index_name
    attr_accessor :elasticsearch_pool_size
    attr_accessor :elasticsearch_timeout

    def initialize
      @elasticsearch = nil
      @elasticsearch_index_name = nil
      @elasticsearch_pool_size = nil
      @elasticsearch_timeout = nil
    end
  end
end
