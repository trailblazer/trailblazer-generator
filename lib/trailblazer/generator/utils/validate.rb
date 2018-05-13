module Trailblazer
  # Trailblazer Generator
  class Generator
    # Generator commands registry
    module Utils
      # Fetch Options
      class Validate
        REGEXP_CONCEPT = /^[A-Z][A-Za-z]{1,}(::[A-Z][A-Za-z]{1,})?/
        REGEXP_NAME = /^[A-Z][A-Za-z]*$/

        def initialize
          @say = Say.new
          @error = Error.new
          @ask = Ask.new
        end

        def concept_name(concept)
          @error.class_name(concept) unless concept.match REGEXP_CONCEPT
        end

        def class_name(name)
          @error.class_name(name) unless name.match REGEXP_NAME
        end

        def source(source)
          return source if Utils::Files.exist?(source)
          @error.source(source)
        end

        def destination(destination)
          return @ask.overwrite?(destination) if Utils::Files.exist?(destination)
          @say.create(destination)
          true
        end

        def write(generation)
          return if Utils::Files.exist?(generation)

          @error.write(generation)
        end
      end
    end
  end
end
