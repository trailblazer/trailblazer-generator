module Trailblazer
  # Trailblazer Generator
  class Generator
    # Generator commands registry
    module Commands
      # Generate Command
      module Generate
        # Generate Operation Command
        class Cells < Base
          desc "Generate default cells: #{DEFAULT_CELLS}"
          example [
            "trb generate cells Blog",
            "trb generate cells Blog --layout=plural"
          ]

          # Required Arguments
          argument :concept, required: true, desc: ARGUMENT_CONCEPT

          # Optional Arguments
          option :view, desc: OPTION_VIEW
          option :layout, default: :singular, values: DEFAULT_LAYOUTS, desc: "Concepts directory layout"
          option :json, desc: OPTION_JSON
          option :path, desc: "Overwrite the destination path manually"

          # Call the individual generators for all default operations
          def call(concept:, **options)
            start_generator(concept, options)
            run_generator :multiple, :cell, Generate::DEFAULT_CELLS
            run_generator :multiple, :view, Generate::DEFAULT_CELLS if options[:view]
            close_generator
          end
        end
      end
    end
  end
end
