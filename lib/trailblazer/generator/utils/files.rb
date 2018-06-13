require "hanami/utils/files"

module Trailblazer
  # Trailblazer Gen
  class Generator
    # Generator commands registry
    module Utils
      # Fetch Options
      class Files
        # TODO: make this default array more accessable/editable
        DEFAULT_MAP = {
          operation: %w[index create update delete show].freeze,
          cell:      %w[index item new edit show].freeze,
          contract:  %w[create update].freeze,
          finder:    %w[list].freeze,
          view:      %w[].freeze
        }.freeze

        def self.mkdir(destination)
          return Utils::Error.new.exist(destination) if exist?(destination)
          Hanami::Utils::Files.mkdir(destination)
          Say.new.create(destination)
          destination
        end

        def self.exist?(path)
          Hanami::Utils::Files.exist?(path)
        end

        def self.get_files(path)
          Dir.glob("#{path}**/*/")
        end

        def self.get_file_name(path)
          path.split[1].to_s
        end
      end
    end
  end
end
