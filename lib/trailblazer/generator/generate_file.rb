module Trailblazer
  # Trailblazer Gen
  class Generator
    class GenerateFile < Trailblazer::Activity::Railway

      def template(ctx, context:, type:, **)
        ctx[:template] = template = {file_name: context.template, path: context.stubs}
        return unless context.stubs == "stubs"

        template[:path] = File.join(__dir__, context.stubs)
        template[:file_name] = if Trailblazer::Generator.file_list.public_send(type).include?(context.template)
                                 context.template
                               else
                                 Utils::Say.new.notice(
                                   "Templete file #{context.template} not found - a generic templete has been used"
                                 )

                                 "generic"
                               end

        ctx[:template] = template
      end

      # rubocop:disable Metrics/ParameterLists
      def source_and_destination(ctx, template:, type:, context:, options:, **)
        ctx[:source]      = Pathname.new(File.join("#{template[:path]}/#{type}/#{template[:file_name]}.erb"))
        ctx[:destination] = Generator::Concept.new(options[:app_dir], options[:concepts_folder]).destination(context)
      end
      # rubocop:enable Metrics/ParameterLists

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

      pass :template
      pass :source_and_destination
      step :validate_source, Output(:failure) => End(:missing_source)
      step :validate_destination, Output(:failure) => End(:file_already_present)
      step :generate_file
      step :validate_generation
    end
  end
end
