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
    attr_accessor :elasticsearch_pool_connection

    def initialize
      @elasticsearch = nil
      @elasticsearch_index_name = nil
      @elasticsearch_pool_connection = nil
    end
  end
end
