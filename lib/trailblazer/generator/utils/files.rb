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
          template    = template(context, type)
          source      = Pathname.new(File.join("#{template[:path]}/#{type}/#{template[:file_name]}.erb"))
          destination = Generator::Concept.destination(context)
          validate    = Utils::Validate.new
          validate.source(source) # used when stub
          return unless validate.destination(destination)
          write(source, destination, context)
          validate.write(destination)
        end

        def self.template(context, type)
          # case not default stubs we let `validation.souce` doing its job
          template = {file_name: context.action, path: context.stubs}
          return template unless context.stubs == "../stubs"

          template[:path] = File.join(__dir__, context.stubs)
          template[:file_name] = DEFAULT_MAP[type].include?(context.action) ? context.action : "generic"
          if template[:file_name] == "generic" && type != :view
            Say.new.notice("Templete file #{context.action} not found - a generic templete has been used")
          end
          template
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
