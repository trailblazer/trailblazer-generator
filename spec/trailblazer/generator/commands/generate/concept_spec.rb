require "spec_helper"
require "pathname"

RSpec.describe Trailblazer::Generator::Commands::Generate::Concept do
  let(:concept) { "SharedExampleConcept" }
  let(:run_command) do
    capture_stdout do
      described_class.new(command_name: "concept").call(concept: concept)
    end
  end

  it "creates a full concept folder" do
    expect(run_command[:stdout]). to include "Starting Generator for Trailblazer Concept"

    Trailblazer::Generator::Utils::Files::DEFAULT_MAP.each do |type, templates|
      next if type == :finder

      templates.each do |template|
        file = Pathname.new("./app/concepts/shared_example_concept/#{type}/#{template}.rb")
        expect(Pathname(file).exist?).to eq true
      end
    end
  end

  context "when concept already exist" do
    let(:concept) { "Post" }

    it "shows an error message" do
      expect { run_command }.to raise_error SystemExit
    end
  end
end
