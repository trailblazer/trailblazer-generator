require "hanami/utils/string"

module Trailblazer
  # Trailblazer Gen
  class Generator
    # Gen commands registry
    module Utils
      # String Utilities
      class String < Hanami::Utils::String
        def self.to_hash(string)
          result = string.split(" ")
          result = result.map do |x|
            x = x.split(":")
            Hash[x.first.to_sym, x.last]
          end
          result.reduce(:merge)
        end

        def self.to_array(string)
          result = string.split(/[\s,']/)
          result.reject(&:empty?)
        end
      end

      require "trailblazer/generator/utils/fetch"
      require "trailblazer/generator/utils/files"
      require "trailblazer/generator/utils/error"
      require "trailblazer/generator/utils/prompt"
      require "trailblazer/generator/utils/say"
      require "trailblazer/generator/utils/ask"
      require "trailblazer/generator/utils/menu"
      require "trailblazer/generator/utils/validate"
      require "trailblazer/generator/utils/parse"
    end
  end
end
