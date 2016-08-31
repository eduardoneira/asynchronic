# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asynchronic/version'

Gem::Specification.new do |spec|
  spec.name          = 'asynchronic'
  spec.version       = Asynchronic::VERSION
  spec.authors       = ['Gabriel Naiman']
  spec.email         = ['gabynaiman@gmail.com']
  spec.description   = 'DSL for asynchronic pipeline'
  spec.summary       = 'DSL for asynchronic pipeline using queues over Redis'
  spec.homepage      = 'https://github.com/gabynaiman/asynchronic'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'redis', '~> 3.0'
  spec.add_dependency 'ost', '~> 0.1'
  spec.add_dependency 'class_config', '~> 0.0'
  spec.add_dependency 'transparent_proxy', '~> 0.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-colorin', '~> 0.1'
  spec.add_development_dependency 'minitest-great_expectations', '~> 0.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'pry-nav'
end
