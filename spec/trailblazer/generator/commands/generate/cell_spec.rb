require "spec_helper"
require "pathname"
require "./spec/trailblazer/generator/commands/shared_example_for_command"

RSpec.describe Trailblazer::Generator::Commands::Generate::Cell do
  let(:command) { described_class }

  it_behaves_like "a single file generation command", "cell"

  context "when passing --view option creates the view file" do
    let(:run_command) { `bin/trailblazer g cell SharedExample New --view=slim` }
    let(:file) { Pathname.new("./app/concepts/shared_example/view/new.slim") }

    it "and shows create messages" do
      expect(run_command).to include "Starting Generator for Trailblazer View"
      expect(run_command).to include "Create"
      expect(run_command).to include "app/concepts/shared_example/view/new.slim"
      expect(Pathname(file).exist?).to eq true
    end
  end
end
