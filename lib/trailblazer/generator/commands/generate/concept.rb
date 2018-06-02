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
          option :layout, default: :singular, values: DEFAULT_LAYOUTS, desc: OPTION_LAYOUT
          option :json, desc: OPTION_JSON
          option :path, desc: OPTION_PATH
          option :stubs, desc: OPTION_STUBS

          def call(concept:, **options)
            run_generator concept, :concept, options
            run_generator concept, :operation, options, Generate::DEFAULT_OPERATIONS
            run_generator concept, :cell, options, Generate::DEFAULT_CELLS
            run_generator concept, :view, options, Generate::DEFAULT_CELLS unless options[:view] == "none"
            run_generator concept, :contract, options, Generate::DEFAULT_CONTRACTS
            close_generator
          end
        end
      end
    end
  end
end
