module Trailblazer
  # Trailblazer Gen
  class Generator
    module Generate
      extend Trailblazer::Activity::Railway()

      REGEXP_CONCEPT = /^[A-Z][A-Za-z]{1,}(::[A-Z][A-Za-z]{1,})?/.freeze
      REGEXP_NAME = /^[A-Z][A-Za-z]*$/.freeze

      module_function

      def validate_concept(_ctx, concept:, **)
        concept.match REGEXP_CONCEPT
      end

      def validate_class_name(_ctx, options:, type:, **)
        return Trailblazer::Activity::Right if type == :concept

        options[:name].match REGEXP_NAME
      end

      def init(ctx, options:, concept:, type:, **)
        concept = Utils::Fetch.concept(concept) unless type == :concept
        ctx[:context] = Utils::Fetch.context(options, type, concept)
      end

      def generate_concept?(_ctx, type:, **)
        type == :concept
      end

      def generate_concept(ctx, context:, **)
        ctx[:destination] = destination = Concept.dir(Utils::String.underscore(context.concept))
        Utils::Files.mkdir(destination)
      end

      # NOTE: why do I have to specifcy Trailblazer::Activity::End here and not in GenerateFile activity??
      step method(:validate_concept), Output(:failure) => Trailblazer::Activity::End(:wrong_concept_format)
      step method(:validate_class_name), Output(:failure) => Trailblazer::Activity::End(:wrong_class_name_format)
      pass method(:init)
      step method(:generate_concept?), Output(:success) => :generate_concept_step, Output(:failure) => :generate_file
      step task: GenerateFile, id: :generate_file,
           GenerateFile.outputs[:success] => "End.success",
           GenerateFile.outputs[:missing_source] => Trailblazer::Activity::End(:missing_source),
           GenerateFile.outputs[:file_already_present] => Trailblazer::Activity::End(:file_already_present),
           GenerateFile.outputs[:failure] => "End.failure"
      step method(:generate_concept), id: :generate_concept_step, Output(:success) => "End.success"
    end
  end
end
