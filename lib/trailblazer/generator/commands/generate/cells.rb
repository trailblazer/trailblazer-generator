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
          option :layout, default: :singular, values: DEFAULT_LAYOUTS, desc: OPTION_LAYOUT
          option :json, desc: OPTION_JSON
          option :path, desc: OPTION_PATH
          option :stubs, desc: OPTION_STUBS

          # Call the individual generators for all default operations
          def call(concept:, **options)
            start_generator(concept, options)
            run_generator :multiple, :cell, Generate::DEFAULT_CELLS
            run_generator :multiple, :view, Generate::DEFAULT_CELLS unless options[:view] == "none"
            close_generator
          end
        end
      end
    end
  end
end
