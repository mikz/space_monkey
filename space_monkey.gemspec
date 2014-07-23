# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'space_monkey/version'

Gem::Specification.new do |spec|
  spec.name          = 'space_monkey'
  spec.version       = SpaceMonkey::VERSION
  spec.authors       = ['Michal Cichra']
  spec.email         = ['michal@o2h.cz']
  spec.summary       = %q{API Client for Space Monkey}
  spec.description   = %q{API Client for Space Monkey device. Experimental.}
  spec.homepage      = ""
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w[lib]

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'

  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday-cookie_jar'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'thor'
  spec.add_dependency 'hashie'
end
