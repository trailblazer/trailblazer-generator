module Trailblazer
  # Trailblazer Generator
  module Generator
    # Generator commands registry
    module Commands
      # Generate Command
      module Generate
        # Generate Cell Command
        class Cell < Base
          desc "Generate a Trailblazer Cell"
          example ["Blog Create", "Blog Create --template=index", "Blog Create --layout=plural"]

          # Required Arguments
          argument :concept, required: true, desc: ARGUMENT_CONCEPT
          argument :name, required: true, desc: ARGUMENT_NAME

          # Optional Arguments
          option :template,        desc: OPTION_TEMPLATE
          option :layout,          desc: OPTION_LAYOUT, default: :singular
          option :json,            desc: OPTION_JSON
          option :path,            desc: OPTION_PATH
          option :stubs,           desc: OPTION_STUBS
          option :app_dir,         desc: OPTION_APP_DIR
          option :concepts_folder, desc: OPTION_CONCEPTS_FOLDER

          def call(concept:, **options)
            read_custom_options
            run_generator concept, :cell, options
            run_generator concept, :view, options unless options[:view] == "none"
            close_generator
          end
        end
      end
    end
  end
end
