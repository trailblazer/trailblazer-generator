module Trailblazer
  # Trailblazer Generator
  class Generator
    # Generator commands registry
    module Commands
      # Generate Command
      module Generate
        # Generate Contract Command
        class Contract < Base
          desc "Generate a Trailblazer Contract"
          example [
            "trb generate contract Blog Create",
            "trb generate contract Blog Create --template=index",
            "trb generate contract Blog Create --layout=plural"
          ]

          # Required Arguments
          argument :concept, required: true, desc: ARGUMENT_CONCEPT
          argument :name, required: true, desc: ARGUMENT_NAME

          # Optional Arguments
          option :template, desc: OPTION_TEMPLATE
          option :layout, default: :singular, values: DEFAULT_LAYOUTS, desc: OPTION_LAYOUT
          option :json, desc: OPTION_JSON
          option :path, desc: OPTION_PATH
          option :stubs, desc: OPTION_STUBS

          # Apply context and call generator
          def call(concept:, **options)
            start_generator(concept, options)
            run_generator :single, :contract
            close_generator
          end
        end
      end
    end
  end
end
