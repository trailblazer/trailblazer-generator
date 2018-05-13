require "erb"
require "json"

module Trailblazer
  # Trailblazer Generator
  class Generator
    # Generator commands registry
    module Utils
      # Fetch Options
      module Parse
        def self.stub(source, context)
          ERB.new(File.read(source), nil, "-").result(context.binding)
        end

        def self.json(source)
          file = File.read(source)
          JSON.parse(file, object_class: OpenStruct) unless file.empty?
        end
      end
    end
  end
end
