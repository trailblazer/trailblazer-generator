module Trailblazer
  module Generator
    class Generate < Trailblazer::Activity::Railway
      REGEXP_CONCEPT = /^[A-Z][A-Za-z]{1,}(::[A-Z][A-Za-z]{1,})?/.freeze
      REGEXP_NAME = /^[A-Z][A-Za-z]*$/.freeze

      def validate_concept(_ctx, concept:, **)
        concept.match REGEXP_CONCEPT
      end

      def validate_class_name(_ctx, options:, type:, **)
        return Trailblazer::Activity::Right if type == :concept

        options[:name].match REGEXP_NAME
      end

      def init(ctx, options:, concept:, type:, **)
        concept = Utils::Fetch.concept(concept, options[:app_dir], options[:concepts_folder]) unless type == :concept
        ctx[:context] = Utils::Fetch.context(options, type, concept)
      end

      def generate_concept?(_ctx, type:, **)
        type == :concept
      end

      def generate_concept(ctx, context:, options:, **)
        ctx[:destination] = destination = Concept.new(options[:app_dir], options[:concepts_folder])
                                                 .dir(Utils::String.underscore(context.concept))
        Utils::Files.mkdir(destination)
      end

      step :validate_concept, Output(:failure) => End(:wrong_concept_format)
      step :validate_class_name, Output(:failure) => End(:wrong_class_name_format)
      pass :init
      step :generate_concept?, Output(:success) => Id(:generate_concept_step), Output(:failure) => Id(:generate_file)
      step Subprocess(GenerateFile), id: :generate_file,
           Output(:success) => End(:success),
           Output(:missing_source) => End(:missing_source),
           Output(:file_already_present) => End(:file_already_present),
           Output(:failure) => End(:failure)
      step :generate_concept, id: :generate_concept_step, Output(:success) => End(:success)
    end
  end
end
