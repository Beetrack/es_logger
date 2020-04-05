module RackEsLogger
  module Elasticsearch
    class Request
      attr_reader :attributes

      def initialize(attributes = {})
        attributes['timestamp'] = Time.now.utc

        @attributes = attributes
      end

      def to_hash
        @attributes
      end
    end
  end
end
