module Trailblazer
  # Trailblazer Generator
  class Generator
    # Generator commands registry
    module Commands
      # Generate Command
      module Generate
        # Generate Cell Command
        class Cell < Base
          desc "Generate a Trailblazer Cell"
          example [
            "trb generate cell Blog Create",
            "trb generate cell Blog Create --action=index",
            "trb generate cell Blog Create --layout=plural"
          ]

          # Required Arguments
          argument :concept, required: true, desc: ARGUMENT_CONCEPT
          argument :name, required: true, desc: ARGUMENT_NAME

          # Optional Arguments
          option :action, desc: OPTION_ACTION
          option :view, desc: OPTION_VIEW
          option :layout, default: :singular, values: DEFAULT_LAYOUTS, desc: OPTION_LAYOUT
          option :json, desc: OPTION_JSON
          option :path, desc: OPTION_PATH
          option :stubs, desc: OPTION_STUBS

          # Apply context and call generator
          def call(concept:, **options)
            start_generator(concept, options)
            run_generator :single, :cell
            run_generator :single, :view if options[:view]
            close_generator
          end
        end
      end
    end
  end
end
