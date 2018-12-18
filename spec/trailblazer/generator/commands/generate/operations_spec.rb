require "spec_helper"
require "pathname"
require "./spec/trailblazer/generator/commands/shared_example_for_commands"

RSpec.describe Trailblazer::Generator::Commands::Generate::Operations do
  let(:concept) { "SharedExampleOperaion" }
  let(:options) { {} }
  let(:run_command) do
    capture_stdout do
      described_class.new(command_name: "operations").call(concept: concept, **options)
    end
  end

  it_behaves_like "a multiple files generation command", described_class, "operations", "operation"

  it "creates a operation folder with default file list" do
    expect(run_command[:stdout]). to include "Starting Generator for Trailblazer Operation"

    Trailblazer::Generator.file_list.operation.each do |template|
      file = Pathname.new("./app/concepts/shared_example_operaion/operation/#{template}.rb")
      expect(Pathname(file).exist?).to eq true
    end
  end

  context "when passing --no-add_type_to_namespace" do
    let(:options) { {add_type_to_namespace: false} }

    it "creates the file list in the correct folder" do
      expect(run_command[:stdout]). to include "Starting Generator for Trailblazer Operation"

      Trailblazer::Generator.file_list.operation.each do |template|
        file = Pathname.new("./app/concepts/shared_example_operaion/#{template}.rb")
        expect(Pathname(file).exist?).to eq true
      end
    end
  end
end
