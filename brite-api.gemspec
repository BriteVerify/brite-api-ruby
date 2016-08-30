require File.expand_path('../lib/brite-api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Alexander Shapiotko', 'BriteVerify']
  gem.email         = ['support@briteverify.com']
  gem.description   = 'Ruby client for BriteVerify API'
  gem.summary       = 'Ruby client for BriteVerify API'
  gem.homepage      = 'https://github.com/BriteVerify/brite-api-ruby'

  gem.files         = Dir.glob('lib/**/**') + ['README.md', 'LICENSE']
  gem.name          = 'brite-api'
  gem.require_paths = ['lib']
  gem.licenses      = ['MIT']
  gem.version       = BriteAPI::VERSION

  gem.required_rubygems_version = '>= 1.3.6'
  gem.required_ruby_version = Gem::Requirement.new('>= 1.9')


  gem.add_runtime_dependency 'rest', '~> 3.0.6'

  gem.add_development_dependency 'shoulda', '>= 0'
  gem.add_development_dependency 'rdoc', '~> 3.12'
  gem.add_development_dependency 'bundler', '> 1.0.0'
  gem.add_development_dependency 'simplecov', '>= 0'
  gem.add_development_dependency 'minitest', '= 3.5.0'
end


