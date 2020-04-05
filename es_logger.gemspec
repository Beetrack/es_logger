require_relative 'lib/es_logger/version'

Gem::Specification.new do |spec|
  spec.name          = 'es_logger'
  spec.version       = EsLogger::VERSION
  spec.licenses      = ['MIT']
  spec.homepage      = 'https://beetrack.com'
  spec.authors       = ['Andres Colonia']
  spec.email         = ['andres.colonia@beetrack.com']
  spec.summary       = 'es_logger is a gem to save logs in Elasticsearh'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.3')
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://beetrack_gemserver.com'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'elasticsearch', '~> 7.5', '>= 7.5.0'
  spec.add_runtime_dependency 'elasticsearch-persistence', '~> 7.0.0', '>= 7.0.0'
  spec.add_runtime_dependency 'rack', '~> 1.5'
  spec.add_runtime_dependency 'sidekiq', '~> 2.4', '>= 2.4.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rack-test', '~> 0.6.3'
end
