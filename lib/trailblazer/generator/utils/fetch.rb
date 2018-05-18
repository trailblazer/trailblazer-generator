module Trailblazer
  # Trailblazer Gen
  class Generator
    # Generator commands registry
    module Utils
      # Fetch Options
      module Fetch
        def self.option(options, key)
          return options.fetch(key) if options.key?(key)
          false
        end

        def self.context(options, type, concept = nil)
          concept_path = Utils::String.underscore(concept)
          type   = option(options, :layout) == "plural" ? "#{type}s" : type.to_s
          name   = option(options, :name)
          action = option(options, :action) || name
          path   = option(options, :path)
          json   = option(options, :json)
          json   = Parse.json(json) if json
          view   = option(options, :view) || "slim"

          Context.new(
            concept: concept, action: action, path: path, type: type, name: name, json: json,
            concept_path: concept_path, view: view
          )
        end

        def self.concept(concept)
          concept_path = Utils::String.underscore(concept)
          return concept if Generator::Concept.exists?(concept_path)
          Generator::Concept.generate(Generator::Concept.dir(concept_path))
          concept
        end
      end
    end
  end
end
