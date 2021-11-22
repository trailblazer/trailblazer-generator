module Trailblazer
  # Trailblazer Gen
  module Generator
    # Register a command to expand Trailblazer-Gen CLI
    def self.register(name, command = nil, aliases: [], &block)
      Commands.register(name, command, aliases: aliases, &block)
    end

    # Gen commands registry
    module Commands
      extend Hanami::CLI::Registry

      require "trailblazer/generator/commands/version"
      require "trailblazer/generator/commands/generate"
    end
  end
end
