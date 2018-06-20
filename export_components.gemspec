
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'export_components/version'

Gem::Specification.new do |spec|
  spec.name          = 'export_components'
  spec.version       = ExportComponents::Rails::VERSION
  spec.authors       = ['DIT']

  spec.summary       = 'great.gov.uk components'
  spec.homepage      = 'https://github.com/uktrade/export_components'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files         = Dir['{app,lib,vendor}/**/*'] + ['README.md']
  spec.bindir        = 'exe'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_dependency 'rails', '~> 5.0'
  spec.add_dependency 'sass'
  spec.add_dependency 'sass-rails'
end
