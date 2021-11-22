module Trailblazer
  # Trailblazer Generator
  module Generator
    # Generator commands registry
    #
    # @since 0.0.1
    # @api private
    module Commands
      # Generate Command
      module Generate
        # Descriptions for common used arguments
        ARGUMENT_CONCEPT = "The concept the generated file(s) should be placed in".freeze
        ARGUMENT_NAME    = "The name for the generated file".freeze

        OPTION_ADD_TYPE_TO_NAMESPACE = "Automatically add type (operation, contract...) in namespace and destination path".freeze

        OPTION_TEMPLATE          = "The template used to generate the file".freeze
        OPTION_PATH              = "Overwrite the destination path manually".freeze
        OPTION_LAYOUT            = "Concepts directory layout".freeze
        OPTION_JSON              = "Json file for population of contract templates".freeze
        OPTION_VIEW              = "Template engine for view files (default erb - pass none to don't create a view file".freeze
        OPTION_STUBS             = "Custom stub path".freeze
        OPTION_APP_DIR           = "Folder where the application is located (default: 'app')".freeze
        OPTION_CONCEPTS_FOLDER   = "Concepts folder where all the TRB object are saved (defaul: 'concepts')".freeze
        OPTION_ACTIVITY_STRATEGY = "Activity strategy which could be: path, fast_track and railway".freeze

        require "trailblazer/generator/commands/generate/base"
        require "trailblazer/generator/commands/generate/concept"
        require "trailblazer/generator/commands/generate/contract"
        require "trailblazer/generator/commands/generate/cell"
        require "trailblazer/generator/commands/generate/cells"
        require "trailblazer/generator/commands/generate/operation"
        require "trailblazer/generator/commands/generate/operations"
        require "trailblazer/generator/commands/generate/finder"
        require "trailblazer/generator/commands/generate/activity"
      end

      register "generate", aliases: ["g"] do |prefix|
        prefix.register "concept", Commands::Generate::Concept
        prefix.register "contract", Commands::Generate::Contract
        prefix.register "cell", Commands::Generate::Cell
        prefix.register "cells", Commands::Generate::Cells
        prefix.register "operation", Commands::Generate::Operation
        prefix.register "operations", Commands::Generate::Operations
        prefix.register "finder", Commands::Generate::Finder
        prefix.register "activity", Commands::Generate::Activity
      end
    end
  end
end
