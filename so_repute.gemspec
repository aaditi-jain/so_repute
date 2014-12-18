# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'so_repute/version'

Gem::Specification.new do |spec|
  spec.name          = "so_repute"
  spec.version       = SoRepute::VERSION
  spec.authors       = ["Aaditi Jain"]
  spec.email         = ["aaditi2290@gmail.com"]
  spec.description   = %q{Fetches stackoverflow information of a person from his/her stackoverflow user_id}
  spec.summary       = %q{Fetches stackoverflow information of a person from his/her stackoverflow user_id}
  spec.homepage      = "https://github.com/Aaditi/so_repute"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "httparty", "~> 0.13.3"
end
