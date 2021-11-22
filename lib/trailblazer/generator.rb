require "hanami/cli"
require "trailblazer-activity-dsl-linear"
require "trailblazer/generator/version"

require "dry-configurable"

module Trailblazer
  # Trailblazer Generator
  module Generator
    extend Dry::Configurable

    # DEFAULT OPTIONS: overridable passing it as option
    setting :view,                  default: "erb",      reader: true
    setting :stubs,                 default: "stubs",    reader: true
    setting :add_type_to_namespace, default: "true",     reader: true
    setting :app_folder,            default: "app",      reader: true
    setting :concepts_folder,       default: "concepts", reader: true
    setting :activity_strategy,     default: "path",     reader: true

    # SETTINGS: not overridable
    setting :file_list, reader: true do
      setting :operation, default: %w[index create update delete show].freeze
      setting :cell,      default: %w[index item new edit show].freeze
      setting :contract,  default: %w[create update].freeze
      setting :finder,    default: %w[list].freeze
      setting :view,      default: %w[].freeze
      setting :activity,  default: %w[activity].freeze
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
