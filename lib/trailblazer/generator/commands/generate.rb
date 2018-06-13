module Trailblazer
  # Trailblazer Generator
  class Generator
    # Generator commands registry
    #
    # @since 0.0.1
    # @api private
    module Commands
      # Generate Command
      module Generate
        # Default arrays
        DEFAULT_OPERATIONS = Utils::Files::DEFAULT_MAP[:operation]
        DEFAULT_CELLS      = Utils::Files::DEFAULT_MAP[:cell]
        DEFAULT_CONTRACTS  = Utils::Files::DEFAULT_MAP[:contract]
        DEFAULT_FINDERS    = Utils::Files::DEFAULT_MAP[:finder]
        DEFAULT_LAYOUTS    = Utils::Files::DEFAULT_MAP[:layout]

        # Descriptions for common used arguments
        ARGUMENT_CONCEPT = "The concept the generated file(s) should be placed in".freeze
        ARGUMENT_NAME    = "The name for the generated file".freeze

        OPTION_TEMPLATE  = "The template used to generate the file".freeze
        OPTION_PATH      = "Overwrite the destination path manually".freeze
        OPTION_LAYOUT    = "Concepts directory layout".freeze
        OPTION_JSON      = "Json file for population of contract templates".freeze
        OPTION_VIEW      = "Template engine for view files (default slim - pass none to don't create a view file".freeze
        OPTION_STUBS     = "Custom stub path".freeze

        require "trailblazer/generator/commands/generate/base"
        require "trailblazer/generator/commands/generate/concept"
        require "trailblazer/generator/commands/generate/contract"
        require "trailblazer/generator/commands/generate/cell"
        require "trailblazer/generator/commands/generate/cells"
        require "trailblazer/generator/commands/generate/operation"
        require "trailblazer/generator/commands/generate/operations"
        require "trailblazer/generator/commands/generate/finder"
      end

      # Rename these to the rightful names later
      register "generate", aliases: ["g"] do |prefix|
        prefix.register "concept", Commands::Generate::Concept
        prefix.register "contract", Commands::Generate::Contract
        prefix.register "cell", Commands::Generate::Cell
        prefix.register "cells", Commands::Generate::Cells
        prefix.register "operation", Commands::Generate::Operation
        prefix.register "operations", Commands::Generate::Operations
        prefix.register "finder", Commands::Generate::Finder
      end
    end
  end
end
