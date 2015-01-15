# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'daily_affirmation/version'

Gem::Specification.new do |spec|
  spec.name          = "daily_affirmation"
  spec.version       = DailyAffirmation::VERSION
  spec.authors       = ["Shane Emmons"]
  spec.email         = ["oss@teamsnap.com"]
  spec.description   = "A simple library for external validations of POROs"
  spec.summary       = "A simple library for external validations of POROs"
  spec.homepage      = "http://teamsnap.github.io/daily_affirmation"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0.0.beta1"
  spec.add_development_dependency "i18n", "~> 0.6.9"
end
