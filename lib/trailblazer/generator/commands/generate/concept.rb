require "trailblazer/generator/gen"

module Trailblazer
  # Trailblazer Generator
  class Generator
    # Generator commands registry
    module Commands
      # Generate Command
      module Generate
        # Generate Operation Command
        class Concept < Base
          desc "Generate an entire Concept"
          example [
            "trb generate concept Blog",
            "trb generate concept Blog --layout=plural"
          ]

          # Required Arguments
          argument :concept, required: true, desc: ARGUMENT_CONCEPT

          # Optional Arguments
          option :view, desc: OPTION_VIEW
          option :layout, default: :singular, values: DEFAULT_LAYOUTS, desc: "Concepts directory layout"
          option :json, desc: OPTION_JSON 
          option :stubs, desc: "Custom stub path"
          option :path, desc: "Overwrite the destination path manually"
          option :stubs, desc: OPTION_STUBS

          # Apply context and call generator
          def call(concept:, **options)
            start_generator(concept, options)
            run_generator :concept, :concept
            run_generator :multiple, :operation, Generate::DEFAULT_OPERATIONS
            run_generator :multiple, :cell, Generate::DEFAULT_CELLS
            run_generator :multiple, :view, Generate::DEFAULT_CELLS if options[:view]
            run_generator :multiple, :contract, Generate::DEFAULT_CONTRACTS
            close_generator
          end
        end
      end
    end
  end
end
