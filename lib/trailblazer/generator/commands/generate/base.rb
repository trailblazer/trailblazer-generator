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
            @say          = Utils::Say.new
            @generator    = nil
            super
          end

          def run_generator(op, type, actions = false)
            @say.start(type)
            @generator.run op, type, actions
            @say.end(type)
          end

          def start_generator(concept, options)
            @generator = Gen.new(concept, options)
          end

          def close_generator
            @say.close
          end
        end
      end
    end
  end
end
