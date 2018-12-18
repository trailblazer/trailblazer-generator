module Trailblazer
  # Trailblazer Gen
  class Generator
    # Concept Declarations
    class Concept
      def initialize(app_dir = nil, concepts_folder = nil)
        @app_dir         = app_dir         || Trailblazer::Generator.app_folder
        @concepts_folder = concepts_folder || Trailblazer::Generator.concepts_folder
      end

      attr_reader :app_dir, :concepts_folder

      def dir(concept)
        "#{root}#{concept}/"
      end

      def root
        "#{app_dir}/#{concepts_folder}/"
      end

      def exists?(context)
        concepts.include?(dir(context))
      end

      def concepts
        Utils::Files.get_files(root)
      end

      def generate(destination)
        Utils::Files.mkdir(destination)
      end

      def destination(context)
        # NOTE:
        # when using the default array to generate the files the context.name is a capitalize string so we need to downcase it
        # instead when commands are called from the user can be anything so we use underscore
        file_name = context.name.is_a?(::String) ? context.name.downcase : context.name.underscore
        # NOTE: need to use include so when --layout=plural is set this is still working
        template  = context.view && context.type.include?("view") ? context.view : "rb"
        "#{context.path ? context.path + "/" : root}#{context.namespace_path}/#{file_name}.#{template}"
      end
    end
  end
end
