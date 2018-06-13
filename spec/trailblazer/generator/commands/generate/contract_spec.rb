require "spec_helper"
require "pathname"
require "./spec/trailblazer/generator/commands/shared_example_for_command"

RSpec.describe Trailblazer::Generator::Commands::Generate::Contract do
  it_behaves_like "a single file generation command", described_class, "contract"
end
