# frozen_string_literal: true

require_relative 'lib/es_logger/version'

Gem::Specification.new do |spec|
  spec.name          = 'es_logger'
  spec.version       = EsLogger::VERSION
  spec.licenses      = ['MIT']
  spec.homepage      = 'https://beetrack.com'
  spec.authors       = ['Andres Colonia']
  spec.email         = ['andres.colonia@beetrack.com']
  spec.summary       = 'es_logger is a gem to save logs in Elasticsearh'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.1')
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/Beetrack'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(Regexp.new('^(test|spec|features)/')) }
  end
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'connection_pool', '~> 2.2.2', '>= 2.2.2'
  spec.add_runtime_dependency 'elasticsearch', '~> 7.4'
  spec.add_runtime_dependency 'elasticsearch-persistence', '~> 7.0.0', '>= 7.0.0'
  spec.add_runtime_dependency 'jwt', '~>2.2.2'
  spec.add_runtime_dependency 'rack', '>= 2', '< 4'
  spec.add_runtime_dependency 'sidekiq', '>= 5.1.3', '<= 6.1.2'
  spec.add_development_dependency 'elasticsearch-extensions', '~> 0.0.31'
  spec.add_development_dependency 'pry', '~> 0.12.2'
  spec.add_development_dependency 'rspec', '~> 3.8', '<= 3.8'
  spec.add_development_dependency 'rubocop', '~>0.75.0'
  spec.add_development_dependency 'simplecov', '~>0.17.0'
end
