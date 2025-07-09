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

  spec.required_ruby_version = Gem::Requirement.new('>= 3.4.2')
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/Beetrack'
  else
    raise 'RubyGems 3.4.2 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(Regexp.new('^(test|spec|features)/')) }
  end
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'connection_pool', '~> 2.5.1', '>= 2.5.1'
  spec.add_runtime_dependency 'elasticsearch', '~> 8.18.0'
  spec.add_runtime_dependency 'elasticsearch-persistence', '~> 8.0.0', '>= 8.0.0'
  spec.add_runtime_dependency 'jwt', '~> 2.10.1'
  spec.add_runtime_dependency 'rack', '>= 2.0', '< 4.0'
  spec.add_runtime_dependency 'sidekiq', '>= 5.2.9', '< 6.0'
  spec.add_development_dependency 'elasticsearch-extensions', '~> 0.0.31'
  spec.add_development_dependency 'pry', '~> 0.15.2'
  spec.add_development_dependency 'rspec', '~> 3.13', '<= 3.13'
  spec.add_development_dependency 'rubocop', '~> 1.75.0'
  spec.add_development_dependency 'simplecov', '~> 0.21.2'
end
