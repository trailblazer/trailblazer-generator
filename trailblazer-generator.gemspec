# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trailblazer/generator/version'

Gem::Specification.new do |spec|
  spec.name          = "trailblazer-generator"
  spec.version       = Trailblazer::Generator::VERSION
  spec.authors       = ["Celso Fernandes", "Nick Sutterer"]
  spec.email         = ["celso.fernandes@gmail.com", "apotonick@gmail.com"]

  spec.summary       = %q{Generators for trailblazer.}
  spec.description   = %q{Generate trailblazer files from your command file}
  spec.homepage      = "https://github.com/trailblazer/trailblazer-generator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ["trailblazer"]
  spec.require_paths = ["lib"]

  spec.add_dependency "cells"
  spec.add_dependency "cells-erb"
  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
