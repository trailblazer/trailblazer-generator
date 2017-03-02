require 'thor'

module Trailblazer
  module Generator
    class Generate < Thor
      desc "operation NAME", "Generates trailblazer file"
      long_desc <<-OPERATION_LONG_DESC

      `generate operation` generate operation file

      OPERATION_LONG_DESC
      option :steps, type: :boolean
      def operation(name)
        Trailblazer::Generator::Operation.new(name, options)
      end
    end

    class Cli < Thor
      desc "generate COMMANDS", "Generates trailblazer file"
      subcommand "generate", Trailblazer::Generator::Generate
    end
  end
end
