require "bundler/setup"
require "simplecov"
SimpleCov.start do
  add_group "Trailblazer-Generator", "lib"
  add_group "Tests", "spec"
end

require "coveralls"
Coveralls.wear!

require "trailblazer/generator"

module Helpers
  # Replace standard input with faked one StringIO.
  def fake_stdin(*args)
    $stdin = StringIO.new
    $stdin.puts(args.shift) until args.empty?
    $stdin.rewind
    yield
  ensure
    $stdin = STDIN
  end

  # does not shows terminal outputs and errors
  # NOTE: use this `bundle exec rspec -f d --color --dry-run ./spec`
  #       to double check the total number of examples
  def capture_stdout(&_block) # rubocop:disable Metrics/MethodLength
    begin
      $stdout = StringIO.new
      $stderr = StringIO.new
      yield
      result = {}
      result[:stdout] = $stdout.string
      result[:stderr] = $stderr.string
    ensure
      $stdout = STDOUT
      $stderr = STDERR
    end
    result
  end

  def generate_dummy_app
    `bin/trailblazer g concept Post`
  end

  def remove_dummy_app
    Hanami::Utils::Files.delete_directory("./app")
  end
end

RSpec.configure do |config|
  include Helpers

  config.before(:suite) do
    generate_dummy_app
  end

  config.after(:suite) do
    remove_dummy_app
  end
end
