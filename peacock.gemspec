# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'peacock/version'

Gem::Specification.new do |spec|
  spec.name          = "peacock"
  spec.version       = Peacock::VERSION
  spec.authors       = ["Christian Paling"]
  spec.email         = ["christian.paling@googlemail.com"]

  spec.summary       = %q{Peacock is a small tool to easily manage your .gitignore}
  spec.description   = %q{Peacock is a small tool to easily manage your .gitignore}
  spec.homepage      = "https://github.com/bakku/peacock"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "simplecov"
end
