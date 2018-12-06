require "hanami/utils/files"

module Trailblazer
  # Trailblazer Gen
  class Generator
    # Generator commands registry
    module Utils
      # Fetch Options
      class Files
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
