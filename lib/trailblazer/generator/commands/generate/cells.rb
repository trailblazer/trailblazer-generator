module Trailblazer
  # Trailblazer Generator
  module Generator
    # Generator commands registry
    module Commands
      # Generate Command
      module Generate
        # Generate Operation Command
        class Cells < Base
          desc "Generate default cells: #{Trailblazer::Generator.file_list.cell}"
          example ["Blog", "Blog --layout=plural"]

          # Required Arguments
          argument :concept, required: true, desc: ARGUMENT_CONCEPT

          # Optional Arguments
          option :view,            desc: OPTION_VIEW
          option :layout,          desc: OPTION_LAYOUT, default: :singular
          option :json,            desc: OPTION_JSON
          option :path,            desc: OPTION_PATH
          option :stubs,           desc: OPTION_STUBS
          option :app_dir,         desc: OPTION_APP_DIR
          option :concepts_folder, desc: OPTION_CONCEPTS_FOLDER

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
