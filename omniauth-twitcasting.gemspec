lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-twitcasting/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-twitcasting"
  spec.version       = Omniauth::Twitcasting::VERSION
  spec.authors       = ["Nobu Funaki"]
  spec.email         = ["nobu@sidefeed.com"]
  spec.summary       = %q{Official OmniAuth strategy for TwitCasting}
  spec.description   = %q{Official OmniAuth strategy for TwitCasting}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "omniauth", "~> 1.8"
  spec.add_dependency "omniauth-oauth2", "~> 1.5"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.7"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "webmock"
end
