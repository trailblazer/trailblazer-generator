require "ostruct"

# CLI command context
module Trailblazer
  # Trailblazer Gen
  class Generator
    # Context Struct
    class Context < OpenStruct
      def initialize(data)
        data = data.each_with_object({}) do |(key, value), result|
          value = Utils::String.new(value) if value.is_a?(::String)
          value = value.underscore if key == :template && value
          result[key] = value
        end

        super(data)
      end

      def with(data)
        self.class.new(to_h.merge(data))
      end

      def binding
        super
      end
    end
  end
end
