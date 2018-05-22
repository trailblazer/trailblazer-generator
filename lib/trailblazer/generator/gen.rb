module Trailblazer
  # Trailblazer Gen
  class Generator
    # Gen commands registry
    class Gen
      # Generate Command

      attr_reader :type, :concept, :options

      def initialize(concept, options)
        @type    = nil
        @options = options
        @concept = concept
        @name    = options[:name]

        validate_concept(concept)
        validate_class_name(@name) if @name # this can't be called when generating a concept folder
      end

      def validate_concept(concept)
        Utils::Validate.new.concept_name(concept)
      end

      def validate_class_name(name)
        Utils::Validate.new.class_name(name)
      end

      def generate_concept(context, _templates)
        Utils::Files.mkdir(Concept.dir(context.concept_path))
      end

      def generate_multiple(context, templates)
        templates.each do |action|
          context.action = action
          # this need to be capitalize because the action comes from the default array
          context.name   = Utils::String.new(action).capitalize
          generate_single(context)
        end
      end

      def generate_single(context, _templates = nil)
        Utils::Files.generate(context, @type)
      end

      def run(op, type, templates)
        @type = type
        send("generate_#{op}", context, templates)
      end

      def context
        @concept = Utils::Fetch.concept(@concept) unless @type == :concept
        Utils::Fetch.context(@options, @type, @concept)
      end
    end
  end
end
