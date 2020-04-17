# frozen_string_literal: true

require 'rails/generators'
require 'rails/generators/named_base'
require 'generators/es_logger/initialize_generator'

module EsLogger
  module Generators
    class InitializeGenerator < ::Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def create_initializer
        say 'creating initializer...'

        template 'initializer.rb', 'config/initializers/es_logger.rb'
      end
    end
  end
end
