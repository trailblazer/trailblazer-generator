require 'thor'
require 'trailblazer/generator/cli/generate'

module Trailblazer
  module Generator
    class Cli < Thor
      desc "generate COMMANDS", "Generates trailblazer file"
      subcommand "generate", Trailblazer::Generator::Generate
    end
  end
end
