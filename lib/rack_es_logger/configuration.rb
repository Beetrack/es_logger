module RackEsLogger
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :elasticsearch

    def initialize
      @elasticsearch = nil
    end
  end
end
