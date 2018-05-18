require "spec_helper"
require "pathname"
require "./spec/trailblazer/generator/commands/shared_example_for_command"

RSpec.describe Trailblazer::Generator::Commands::Generate::Cell do
  let(:command) { described_class }

  it_behaves_like "a single file generation command", "cell", true

  context "when passing none to --view option" do
    let(:run_command) { `bin/trailblazer g cell SharedExample SomeStuff --view=none` }
    let(:cell_file) { Pathname.new("./app/concepts/shared_example/cell/some_stuff.rb") }
    let(:view_file) { Pathname.new("./app/concepts/shared_example/view/some_stuff.slim") }

    it "does not create the view file" do
      run_command

      expect(Pathname(cell_file).exist?).to eq true
      expect(Pathname(view_file).exist?).to eq false
    end
  end
end
