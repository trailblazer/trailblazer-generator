require "hanami/utils/files"

module Trailblazer
  # Trailblazer Gen
  class Generator
    # Generator commands registry
    module Utils
      # Fetch Options
      class Files
        # TODO: make this default array more accessable/editable and move in one spot only
        DEFAULT_MAP = {
          operation: %w[index create update delete show].freeze,
          cell:      %w[index item new edit show].freeze,
          contract:  %w[create update].freeze,
          finder:    %w[list].freeze,
          view:      %w[].freeze
        }.freeze

        def self.generate(context, type)
          source_file = DEFAULT_MAP[type].include?(context.action) ? context.action : "generic"
          if source_file == "generic" && type != :view
            Say.new.notice("Templete file #{context.action} not found - a generic templete has been used")
          end
          source      = Pathname.new(File.join(__dir__, "../stubs/#{type}/#{source_file}.erb"))
          destination = Generator::Concept.destination(context)
          validate    = Utils::Validate.new
          validate.source(source) # now this one will never fail probably...leave it here to be sure?
          return unless validate.destination(destination)
          write(source, destination, context)
          validate.write(destination)
        end

        def self.write(source, destination, context)
          Hanami::Utils::Files.write(destination, Parse.stub(source, context))
        end

        def self.mkdir(destination)
          return Utils::Error.new.exist(destination) if exist?(destination)
          Hanami::Utils::Files.mkdir(destination)
          Say.new.create(destination)
        end

        def self.exist?(path)
          Hanami::Utils::Files.exist?(path)
        end

        # This now returns the list of all folders under app/concepts
        def self.get_files(path)
          Dir.glob("#{path}**/*/") # .map { |file| File.basename(file) }
        end

        # TODO: this is really similar to get_files - do we need it?
        def self.get_file_name(path)
          path.split[1].to_s
        end
      end
    end
  end
end
