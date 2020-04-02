require 'rails/generators'
require 'rails/generators/named_base'
require 'generators/rack_es_logger/initialize_generator'

module RackEsLogger
  module Generators
    class InitializeGenerator < ::Rails::Generators::Base

      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def create_initializer
        say 'creating initializer...'

        template 'initializer.rb', 'config/initializers/rack_es_logger.rb', :assigns => { :access_token => 'value' }
      end
    end
  end
end
