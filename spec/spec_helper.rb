require "bundler/setup"
require "simplecov"
SimpleCov.start do
  add_group "Trailblazer-Generator", "lib"
  add_group "Tests", "spec"
end

require "trailblazer/generator"

module Helpers
  # Replace standard input with faked one StringIO.
  def fake_stdin(*args)
    begin
      $stdin = StringIO.new
      $stdin.puts(args.shift) until args.empty?
      $stdin.rewind
      yield
    ensure
      $stdin = STDIN
    end
  end

  # does not shows terminal outputs and errors
  def capture_stdout(&_block)
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
    gen_concepts = Trailblazer::Generator::Commands::Generate::Concept.new(command_name: "concept")
    capture_stdout { gen_concepts.call(concept: 'Post') } # TODO: we still have something shown in the terminal - fix it!
  end

  def remove_dummy_app
    Hanami::Utils::Files.delete_directory('./app')
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
