module Trailblazer
  # Trailblazer Generator
  class Generator
    # Generator commands registry
    module Commands
      # Generate Command
      module Generate
        # Generate Finder Command
        class Finder < Base
          desc "Generate a Trailblazer Finder"
          example [
            "trb generate finder Blog Create",
            "trb generate finder Blog Create --action=index",
            "trb generate finder Blog Create --layout=plural"
          ]

          # Required Arguments
          argument :concept, required: true, desc: ARGUMENT_CONCEPT
          argument :name, required: true, desc: ARGUMENT_NAME

          # Optional Arguments
          option :action, desc: OPTION_ACTION
          option :layout, default: :singular, values: DEFAULT_LAYOUTS, desc: OPTION_LAYOUT
          option :json, desc: OPTION_JSON 
          option :path, desc: OPTION_PATH

          # Apply context and call generator
          def call(concept:, **options)
            start_generator(concept, options)
            run_generator :single, :finder
            close_generator
          end
        end
      end
    end
  end
end
