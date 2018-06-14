module Trailblazer
  # Trailblazer Gen
  class Generator
    module GenerateFile
      extend Trailblazer::Activity::Railway()

      module_function

      def template(ctx, context:, type:, **) # rubocop:disable Metrics/AbcSize
        ctx[:template] = template = {file_name: context.template, path: context.stubs}
        return unless context.stubs == "stubs"

        template[:path] = File.join(__dir__, context.stubs)
        template[:file_name] = Utils::Files::DEFAULT_MAP[type].include?(context.template) ? context.template : "generic"
        if template[:file_name] == "generic" && type != :view
          Utils::Say.new.notice(
            "Templete file #{context.template} not found - a generic templete has been used"
          )
        end
        ctx[:template] = template
      end

      def source_and_destination(ctx, template:, type:, context:, **)
        ctx[:source]      = Pathname.new(File.join("#{template[:path]}/#{type}/#{template[:file_name]}.erb"))
        ctx[:destination] = Generator::Concept.destination(context)
      end

      def validate_source(_ctx, source:, **)
        Utils::Files.exist?(source)
      end

      def validate_destination(_ctx, destination:, **)
        return Utils::Ask.new.overwrite?(destination) if Utils::Files.exist?(destination)
        Utils::Say.new.create(destination)
        true
      end

      def generate_file(_ctx, destination:, source:, context:, **)
        Hanami::Utils::Files.write(destination, Utils::Parse.stub(source, context))
      end

      def validate_generation(_ctx, destination:, **)
        Utils::Files.exist?(destination)
      end

      pass method(:template)
      pass method(:source_and_destination)
      step method(:validate_source), Output(:failure) => End(:missing_source)
      step method(:validate_destination), Output(:failure) => End(:file_already_present)
      step method(:generate_file)
      step method(:validate_generation)
    end
  end
end
