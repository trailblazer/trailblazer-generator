require 'thor'

module Trailblazer
  module Generator
    class Generate < Thor
      class_option :action, :type => :string, :required => true

      desc "operation NAME", "Generates operation file"
      long_desc <<-OPERATION_LONG_DESC

      `generate operation` generate operation file

      OPERATION_LONG_DESC
      option :present, type: :boolean
      def operation(name)
        Trailblazer::Generator::Builder::Operation.(name: name, options: options)
      end

      desc "cell NAME", "Generates cell file"
      long_desc <<-CELL_LONG_DESC

      `generate cell` generate cell file

      CELL_LONG_DESC
      def cell(name)
        Trailblazer::Generator::Builder::Cell.(name: name, options: options)
      end
    end

    class Cli < Thor
      desc "generate COMMANDS", "Generates trailblazer file"
      subcommand "generate", Trailblazer::Generator::Generate
    end
  end
end
