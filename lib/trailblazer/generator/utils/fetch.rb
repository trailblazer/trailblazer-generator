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

        def self.context(options, type, concept)
          type           = option(options, :layout) == "plural" ? "#{type}s" : type.to_s
          name           = option(options, :name)
          template       = option(options, :template) || name
          path           = option(options, :path)
          json           = option(options, :json)
          json           = Parse.json(json) if json
          view           = option(options, :view) || Trailblazer::Generator.view
          stubs          = option(options, :stubs) || Trailblazer::Generator.stubs
          namespace      = self.namespace(options, concept, type)
          namespace_path = Utils::String.underscore(namespace)

          Context.new(
            concept: concept, template: template, path: path, type: type, name: name, json: json,
            view: view, stubs: stubs, namespace: namespace, namespace_path: namespace_path
          )
        end

        def self.concept(concept_name, app_dir, concepts_folder)
          concept_path = Utils::String.underscore(concept_name)
          concept = Generator::Concept.new(app_dir, concepts_folder)

          return concept_name if concept.exists?(concept_path)

          concept.generate(concept.dir(concept_path))
          concept_name
        end

        def self.namespace(options, concept, type)
          add_type_to_namespace = if options[:add_type_to_namespace].nil?
                                    Trailblazer::Generator.add_type_to_namespace == "true"
                                  else
                                    options[:add_type_to_namespace]
                                  end

          namespace = concept
          namespace += "::#{type.capitalize}" if add_type_to_namespace
          namespace
        end
      end
    end
  end
end
