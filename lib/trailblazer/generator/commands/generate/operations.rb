module Trailblazer
  # Trailblazer Generator
  class Generator
    # Generator commands registry
    module Commands
      # Generate Command
      module Generate
        # Generate Operation Command
        class Operations < Base
          desc "Generate default operations: #{Trailblazer::Generator.file_list.operation}"
          example [
            "trb generate operations Blog",
            "trb generate operations Blog --layout=plural"
          ]

          # Required Arguments
          argument :concept, required: true, desc: ARGUMENT_CONCEPT

          # Optional Arguments
          option :layout, default: :singular, desc: OPTION_LAYOUT
          option :json, desc: OPTION_JSON
          option :path, desc: OPTION_PATH
          option :stubs, desc: OPTION_STUBS

          def call(concept:, **options)
            run_generator concept, :operation, options, Trailblazer::Generator.file_list.operation
            close_generator
          end
        end
      end
    end
  end
end
