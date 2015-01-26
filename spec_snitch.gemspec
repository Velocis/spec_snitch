# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spec_snitch/version'

Gem::Specification.new do |spec|
  spec.name          = "SpecSnitch"
  spec.version       = SpecSnitch::VERSION
  spec.authors       = ["Freddy Rangel", "John Ellis"]
  spec.email         = ["frederick.rangel@gmail.com", "john@seriouslyawesome.com"]
  spec.summary       = %q{Turn your pending specs into GitHub issues.}
  spec.description   = %q{Using only a GitHub API access token and the name of your repo, SpecSnitch will create GitHub issues using the full descriptions of your pending specs.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "aruba", "~> 0.6.2"
end
