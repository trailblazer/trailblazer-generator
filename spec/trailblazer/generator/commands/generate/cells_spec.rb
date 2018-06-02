require "spec_helper"
require "pathname"

RSpec.describe Trailblazer::Generator::Commands::Generate::Cells do
  let(:concept) { "SharedExampleCell" }
  let(:run_command) do
    capture_stdout do
      described_class.new(command_name: "cells").call(concept: concept)
    end
  end

  it "creates a cell folder with corrispective views" do
    expect(run_command[:stdout]). to include "Starting Generator for Trailblazer Cell"
    expect(run_command[:stdout]). to include "Starting Generator for Trailblazer View"

    Trailblazer::Generator::Utils::Files::DEFAULT_MAP[:cell].each do |template|
      file = Pathname.new("./app/concepts/shared_example_cell/cell/#{template}.rb")
      view_file = Pathname.new("./app/concepts/shared_example_cell/view/#{template}.erb")
      expect(Pathname(file).exist?).to eq true
      expect(Pathname(view_file).exist?).to eq true
    end
  end
end
