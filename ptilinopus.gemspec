# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ptilinopus/version'

Gem::Specification.new do |spec|
  spec.name          = "ptilinopus"
  spec.version       = Ptilinopus::VERSION
  spec.authors       = ["Ivan Kabluchkov"]
  spec.email         = ["ikabluchkov@gmail.com"]
  spec.description   = %q{API wrapper for Mailerlite}
  spec.summary       = %q{API wrapper for Mailerlite}
  spec.homepage      = "http://github.com/lfidnl/ptilinopus"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "fakeweb"
  spec.add_development_dependency "json"

  spec.add_dependency('httparty')
end
