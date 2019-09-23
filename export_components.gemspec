
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'export_components/version'

Gem::Specification.new do |spec|
  spec.name          = 'export_components'
  spec.version       = ExportComponents::VERSION
  spec.authors       = ['DIT']

  spec.summary       = 'great.gov.uk components'
  spec.homepage      = 'https://github.com/uktrade/export_components'
  spec.license       = 'MIT'

  spec.files         = Dir['{app,lib}/**/*'] + ['README.md']
  spec.bindir        = 'exe'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'combustion'
  spec.add_development_dependency 'rspec-rails', '~> 3.7'
  spec.add_development_dependency 'byebug'
  spec.add_dependency 'rails', '~> 5.2'
end
