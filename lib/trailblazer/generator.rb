require "hanami/cli"
require "trailblazer-activity"
require "trailblazer/generator/version"

require "dry-configurable"

module Trailblazer
  # Trailblazer Generator
  class Generator
    extend Dry::Configurable

    # DEFAULT OPTIONS: overridable passing it as option
    setting :view,                  "erb",   reader: true
    setting :stubs,                 "stubs", reader: true
    setting :add_type_to_namespace, "true",  reader: true
    setting :app_folder,            "app",      reader: true
    setting :concepts_folder,       "concepts", reader: true

    # SETTINGS: not overridable
    setting :file_list, reader: true do
      setting :operation, %w[index create update delete show].freeze
      setting :cell,      %w[index item new edit show].freeze
      setting :contract,  %w[create update].freeze
      setting :finder,    %w[list].freeze
      setting :view,      %w[].freeze
    end
  end
end

require "trailblazer/generator/utils"
require "trailblazer/generator/custom_options"
require "trailblazer/generator/context"
require "trailblazer/generator/commands"
require "trailblazer/generator/concept"
require "trailblazer/generator/generate_file"
require "trailblazer/generator/generate"
