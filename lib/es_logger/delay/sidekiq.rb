require 'sidekiq'

module EsLogger
  module Delay
    class Sidekiq

      OPTIONS = { 'queue' => 'es_logger', 'class' => EsLogger::Delay::Sidekiq }.freeze

      def initialize(*args)
        @options = (opts = args.shift) ? OPTIONS.merge(opts) : OPTIONS
      end

      def call(payload)
        raise StandardError, 'Unable to push the job to Sidekiq' if ::Sidekiq::Client.push(@options.merge('args' => [payload])).nil?
      end

      include ::Sidekiq::Worker

      def perform(args)
        EsLogger::Request.call(args)
      end
    end
  end
end
