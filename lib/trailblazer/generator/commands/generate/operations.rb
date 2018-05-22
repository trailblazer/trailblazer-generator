module Trailblazer
  # Trailblazer Generator
  class Generator
    # Generator commands registry
    module Commands
      # Generate Command
      module Generate
        # Generate Operation Command
        class Operations < Base
          desc "Generate default operations: #{DEFAULT_OPERATIONS}"
          example [
            "trb generate operations Blog",
            "trb generate operations Blog --layout=plural"
          ]

          # Required Arguments
          argument :concept, required: true, desc: ARGUMENT_CONCEPT

          # Optional Arguments
          option :layout, default: :singular, values: DEFAULT_LAYOUTS, desc: OPTION_LAYOUT
          option :json, desc: OPTION_JSON
          option :path, desc: OPTION_PATH
          option :stubs, desc: OPTION_STUBS

          # Call the individual generators for all default operations
          def call(concept:, **options)
            start_generator(concept, options)
            run_generator :multiple, :operation, Generate::DEFAULT_OPERATIONS
            close_generator
          end
        end
      end
    end
  end
end
