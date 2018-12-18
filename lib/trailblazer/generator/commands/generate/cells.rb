module Trailblazer
  # Trailblazer Generator
  class Generator
    # Generator commands registry
    module Commands
      # Generate Command
      module Generate
        # Generate Operation Command
        class Cells < Base
          desc "Generate default cells: #{Trailblazer::Generator.file_list.cell}"
          example [
            "trb generate cells Blog",
            "trb generate cells Blog --layout=plural"
          ]

          # Required Arguments
          argument :concept, required: true, desc: ARGUMENT_CONCEPT

          # Optional Arguments
          option :view, desc: OPTION_VIEW
          option :layout, default: :singular, desc: OPTION_LAYOUT
          option :json, desc: OPTION_JSON
          option :path, desc: OPTION_PATH
          option :stubs, desc: OPTION_STUBS

          def call(concept:, **options)
            read_custom_options
            run_generator concept, :cell, options, Trailblazer::Generator.file_list.cell
            run_generator concept, :view, options, Trailblazer::Generator.file_list.cell unless options[:view] == "none"
            close_generator
          end
        end
      end
    end
  end
end
