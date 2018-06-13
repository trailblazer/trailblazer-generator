module Trailblazer
  # Trailblazer Gen
  class Generator
    # Concept Declarations
    class Concept
      def self.app_dir
        "app"
      end

      def self.concepts_dir
        "concepts"
      end

      def self.dir(concept)
        "#{root}#{concept}/"
      end

      def self.root
        "#{app_dir}/#{concepts_dir}/"
      end

      def self.exists?(context)
        concepts.include?(dir(context))
      end

      def self.concepts
        Utils::Files.get_files(root)
      end

      # NOTE: type is added in context so the namespace will be changed dynamically in base on --layout
      # def self.layout(layout, action, type)
      #   return "#{type}s/#{action}.rb" if layout == "plural"
      #   # return "#{type}.rb" if layout == "compound-singular" # @todo should we even support this?
      #   "#{type}/#{action}.rb"
      # end

      def self.generate(destination)
        Utils::Files.mkdir(destination)
      end

      def self.destination(context) # rubocop:disable Metrics/AbcSize
        # NOTE:
        # when using the default array to generate the files the context.name is a capitalize string so we need just downcase
        # instead when commands are called from the user can be anything so we use underscore
        file_name = context.name.is_a?(::String) ? context.name.downcase : context.name.underscore
        # NOTE: need to use include so when --layout=plural is set this is still working
        template  = context.view && context.type.include?("view") ? context.view : "rb"
        "#{context.path ? context.path + "/" : root}#{context.concept_path}/#{context.type}/#{file_name}.#{template}"
      end
    end
  end
end
