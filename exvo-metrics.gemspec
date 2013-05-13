# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exvo/metrics/version'

Gem::Specification.new do |spec|
  spec.name          = "exvo-metrics"
  spec.version       = Exvo::Metrics::VERSION
  spec.authors       = ["Paweł Gościcki"]
  spec.email         = ["pawel.goscicki@gmail.com"]
  spec.description   = "Metrics wrapper for Exvo apps."
  spec.summary       = "Wrapper for metrics for Exvo apps."
  spec.homepage      = "https://github.com/Exvo/exvo-metrics"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
