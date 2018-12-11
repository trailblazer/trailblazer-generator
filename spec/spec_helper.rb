require "bundler/setup"
require "simplecov"
SimpleCov.start do
  add_filter "/.bundle/"
  add_group "Trailblazer-Generator", "lib"
  add_group "Tests", "spec"
end

require "trailblazer/generator"
require "dry/configurable/test_interface"

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
    `bin/trailblazer g concept Post`
  end

  def remove_dummy_app
    Hanami::Utils::Files.delete_directory("./app")
  end

  def remove_custom_app
    return unless Dir.exist?("./custom")

    Hanami::Utils::Files.delete_directory("./custom")
  end
end

# NOTE: uncomment this to troubleshoot tests
# Trailblazer::Generator::Utils::Error.class_eval do
#   def source(context)
#   end

#   def exist(context)
#   end

#   def write(context)
#   end

#   def class_name(class_name)
#   end
# end

# Trailblazer::Generator::Utils::Menu.class_eval do
#   def overwrite(destination)
#   end
# end

RSpec.configure do |config|
  include Helpers

  config.before(:suite) do
    generate_dummy_app
  end

  config.after(:suite) do
    remove_dummy_app
    remove_custom_app
  end
end
