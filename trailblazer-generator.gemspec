lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "trailblazer/generator/version"

Gem::Specification.new do |spec|
  spec.name          = "trailblazer-generator"
  spec.version       = Trailblazer::Generator::VERSION
  spec.authors       = ["Nick Sutterer", "Marc Tich", "Emanuele Magliozzi"]
  spec.email         = ["apotonick@gmail.com", "marc@mudsu.com", "emanuele.magliozzi@gmail.com"]
  spec.summary       = "Generator for Trailblazer."
  spec.description   = "Generate Trailblazer files from your command line"
  spec.homepage      = "http://trailblazer.to"
  spec.license       = "LGPL-3.0"

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r(^bin/)) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.bindir        = "bin"
  spec.require_paths = ["lib"]

  spec.add_dependency "hanami-cli"
  spec.add_dependency "hanami-utils"
  spec.add_dependency "highline", "~> 2.0.0.pre.develop.14"
  spec.add_dependency "trailblazer-activity"
  spec.add_dependency "tty-prompt", "~> 0.15.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "rspec-mocks", "~> 3.5"
  spec.add_development_dependency "rspec_junit_formatter"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "simplecov"

  spec.required_ruby_version = ">= 2.1.0"
end
