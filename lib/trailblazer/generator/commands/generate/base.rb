module Trailblazer
  # Trailblazer Generator
  class Generator
    # Gen commands registry
    module Commands
      # Generate Command
      module Generate
        # Generate Operation Command
        class Base < Hanami::CLI::Command
          attr_reader :command_name, :generator, :say

          def initialize(command_name)
            @say = Utils::Say.new
            @error = Utils::Error.new
            super
          end

          def run_generator(concept, type, options, templates = [nil])
            @say.start(type)

            # templates is passed for multifile generation commands
            # otherwise execute this ones and not modifing template
            templates.each do |template|
              options[:name] = Utils::String.new(template).capitalize unless template.nil?
              signal, (ctx, *) = generate.call([{options: options, type: type, concept: concept}, {}])
              end_point(signal, concept, options, ctx)
            end

            @say.end(type)
          end

          def close_generator
            @say.close
          end

          private

          def end_point(signal, concept, options, ctx)
            case signal
              when generate_signal(:wrong_concept_format)
                @error.class_name(concept)
              when generate_signal(:wrong_class_name_format)
                @error.class_name(options[:name])
              when generate_signal(:missing_source)
                @error.source(ctx[:source])
              else
                true
            end
          end

          def generate
            Trailblazer::Generator::Generate
          end

          def generate_signal(key)
            generate.outputs[key].signal
          end
        end
      end
    end
  end
end
