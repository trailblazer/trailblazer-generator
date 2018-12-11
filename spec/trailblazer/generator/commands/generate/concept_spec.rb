require "spec_helper"
require "pathname"

RSpec.describe Trailblazer::Generator::Commands::Generate::Concept do
  let(:concept) { "SharedExampleConcept" }
  let(:options) { {concept: concept} }
  let(:run_command) do
    capture_stdout do
      described_class.new(command_name: "concept").call(options)
    end
  end

  it "creates a full concept folder" do
    expect(run_command[:stdout]). to include "Starting Generator for Trailblazer Concept"

    %i[operation cell contract view].each do |type|
      Trailblazer::Generator.file_list.public_send(type).each do |template|
        file = Pathname.new("./app/concepts/shared_example_concept/#{type}/#{template}.rb")
        expect(Pathname(file).exist?).to eq true
      end
    end
  end

  context "able to use --app_dir" do
    let(:options) { {concept: concept, app_dir: "custom"} }

    it "to generate files in a different folder" do
      expect(run_command[:stdout]). to include "Starting Generator for Trailblazer Concept"

      %i[operation cell contract view].each do |type|
        expect(run_command[:stdout]). to include "Starting Generator for Trailblazer #{type.capitalize}"
        expect(run_command[:stdout]). to include "Starting Generator for Trailblazer View" if type == :view

        Trailblazer::Generator.file_list.public_send(type).each do |template|
          file = Pathname.new("./custom/concepts/shared_example_concept/#{type}/#{template}.rb")
          expect(Pathname(file).exist?).to eq true

          if type == :view
            view_file = Pathname.new("./custom/concepts/shared_example_concept/view/#{template}.erb")
            expect(Pathname(view_file).exist?).to eq true
          end
        end
      end
    end
  end

  context "able to use --concepts_folder" do
    let(:options) { {concept: concept, concepts_folder: "custom"} }

    it "to generate files in a different folder" do
      expect(run_command[:stdout]). to include "Starting Generator for Trailblazer Concept"

      %i[operation cell contract view].each do |type|
        expect(run_command[:stdout]). to include "Starting Generator for Trailblazer #{type.capitalize}"
        expect(run_command[:stdout]). to include "Starting Generator for Trailblazer View" if type == :view

        Trailblazer::Generator.file_list.public_send(type).each do |template|
          file = Pathname.new("./app/custom/shared_example_concept/#{type}/#{template}.rb")
          expect(Pathname(file).exist?).to eq true

          if type == :view
            view_file = Pathname.new("./app/custom/shared_example_concept/view/#{template}.erb")
            expect(Pathname(view_file).exist?).to eq true
          end
        end
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
