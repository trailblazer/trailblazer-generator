require "spec_helper"
require "pathname"

RSpec.describe Trailblazer::Generator::Commands::Generate::Operations do
  let(:concept) { "SharedExampleOperaion" }
  let(:run_command) do
    capture_stdout do
      described_class.new(command_name: "operations").call(concept: concept)
    end
  end

  it "creates a cell folder with corrispective views" do
    expect(run_command[:stdout]). to include "Starting Generator for Trailblazer Operation"

    Trailblazer::Generator::Utils::Files::DEFAULT_MAP[:operation].each do |template|
      file = Pathname.new("./app/concepts/shared_example_operaion/operation/#{template}.rb")
      expect(Pathname(file).exist?).to eq true
    end
  end
end
