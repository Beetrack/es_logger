require_relative 'lib/rack_es_logger/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack_es_logger'
  spec.version       = RackEsLogger::VERSION
  spec.licenses      = ['MIT']
  spec.homepage      = 'https://beetrack.com'
  spec.authors       = ['Andres Colonia']
  spec.email         = ['andres.colonia@beetrack.com']
  spec.summary       = 'rack_es_logger is a middleware gem to save logs using \
  Elastic Search'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.3')
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://beetrack_gemserver.com'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rack', '>= 1.5.3'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rack-test'
end
