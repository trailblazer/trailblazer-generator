module Trailblazer
  # Trailblazer Gen
  class Generator
    # Concept Declarations
    class Concept
      def self.app_dir
        Trailblazer::Generator.app_folder
      end

      def self.concepts_dir
        Trailblazer::Generator.app_folder
      end

      def self.dir(concept)
        "#{root}#{concept}/"
      end

      def self.root
        "#{Trailblazer::Generator.app_folder}/#{Trailblazer::Generator.concepts_folder}/"
      end

      def self.exists?(context)
        concepts.include?(dir(context))
      end

      def self.concepts
        Utils::Files.get_files(root)
      end

      def self.generate(destination)
        Utils::Files.mkdir(destination)
      end

      def self.destination(context)
        # NOTE:
        # when using the default array to generate the files the context.name is a capitalize string so we need to downcase it
        # instead when commands are called from the user can be anything so we use underscore
        file_name = context.name.is_a?(::String) ? context.name.downcase : context.name.underscore
        # NOTE: need to use include so when --layout=plural is set this is still working
        template  = context.view && context.type.include?("view") ? context.view : "rb"
        "#{context.path ? context.path + "/" : root}#{context.concept_path}/#{context.type}/#{file_name}.#{template}"
      end
    end
  end
end
