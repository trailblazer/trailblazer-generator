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
            "trb generate cell Blog Create --template=index",
            "trb generate cell Blog Create --layout=plural"
          ]

          # Required Arguments
          argument :concept, required: true, desc: ARGUMENT_CONCEPT
          argument :name, required: true, desc: ARGUMENT_NAME

          # Optional Arguments
          option :template, desc: OPTION_TEMPLATE
          option :view, desc: OPTION_VIEW
          option :layout, default: :singular, desc: OPTION_LAYOUT
          option :json, desc: OPTION_JSON
          option :path, desc: OPTION_PATH
          option :stubs, desc: OPTION_STUBS

          def call(concept:, **options)
            run_generator concept, :cell, options
            run_generator concept, :view, options unless options[:view] == "none"
            close_generator
          end
        end
      end
    end
  end
end
