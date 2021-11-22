module Trailblazer
  # Trailblazer Generator
  module Generator
    # Generator commands registry
    #
    # @since 0.0.1
    # @api private
    module Commands
      # Version Command
      class Version < Hanami::CLI::Command
        desc "Print version"

        def call(*)
          puts "Trailblazer-Generator #{Generator::VERSION}"
        end
      end

      register "version", Version, aliases: ["v", "-v", "--version"]
    end
  end
end
