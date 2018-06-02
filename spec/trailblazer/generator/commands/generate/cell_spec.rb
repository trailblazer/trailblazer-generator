require "spec_helper"
require "pathname"
require "./spec/trailblazer/generator/commands/shared_example_for_command"

RSpec.describe Trailblazer::Generator::Commands::Generate::Cell do
  it_behaves_like "a single file generation command", described_class, "cell", true

  context "when passing none to --view option" do
    let(:concept) { "SharedExample" }
    let(:options) { {name: "SomeStuff", view: "none"} }
    let(:run_command) do
      capture_stdout do
        described_class.new(command_name: "cell").call(options.merge(concept: concept))
      end
    end
    let(:cell_file) { Pathname.new("./app/concepts/shared_example/cell/some_stuff.rb") }
    let(:view_file) { Pathname.new("./app/concepts/shared_example/view/some_stuff.slim") }

    it "does not create the view file" do
      run_command

      expect(Pathname(cell_file).exist?).to eq true
      expect(Pathname(view_file).exist?).to eq false
    end
  end
end
