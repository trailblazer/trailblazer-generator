require "spec_helper"
require "./spec/trailblazer/generator/shared_example_for_activities"

RSpec.describe Trailblazer::Generator::Generate do
  let(:options) do
    {
      template: template,
      name: "New",
      stubs: stubs
    }
  end
  let(:type) { :operation }
  let(:stubs) { "stubs" }
  let(:template) { "create" }
  let(:concept) { "Blog" }
  let(:path) { Pathname.new("./app/concepts/blog/operation/new.rb") }

  subject(:generate) { described_class }

  it_behaves_like "the GenerateFile activity", described_class do
    let(:result) { generate.call([{options: options, type: type, concept: concept}, {}]) }
  end

  context "concept validation" do
    context "correct format" do
      %w[Report::Create Report RePort].each do |concept|
        it "returns :success signal" do
          capture_stdout do
            signal, (_ctx, *) = generate.call([{options: options, type: type, concept: concept}, {}])

            expect(signal).to eq described_class.outputs[:success].signal
          end
        end
      end
    end

    context "wrong format" do
      %w[report 1234].each do |concept|
        it "returns :wrong_concept_format signal" do
          capture_stdout do
            signal, (_ctx, *) = generate.call([{options: options, type: type, concept: concept}, {}])

            expect(signal).to eq described_class.outputs[:wrong_concept_format].signal
          end
        end
      end
    end
  end

  context "class name validation" do
    context "correct format" do
      %w[Report RePort].each do |name|
        it "returns :success signal" do
          options[:name] = name
          capture_stdout do
            signal, (_ctx, *) = generate.call([{options: options, type: type, concept: concept}, {}])

            expect(signal).to eq described_class.outputs[:success].signal
          end
        end
      end
    end

    context "wrong format" do
      %w[report 1234].each do |name|
        it "returns :wrong_concept_format signal" do
          options[:name] = name
          capture_stdout do
            signal, (_ctx, *) = generate.call([{options: options, type: type, concept: concept}, {}])

            expect(signal).to eq described_class.outputs[:wrong_class_name_format].signal
          end
        end
      end
    end
  end

  context "when passing :concept as type" do
    let(:type) { :concept }
    let(:concept) { "Uluwatu" }

    it "creates only the concept folder" do
      capture_stdout do
        signal, (ctx, *) = generate.call([{options: options, type: type, concept: concept}, {}])

        expect(signal).to eq described_class.outputs[:success].signal
        expect(ctx[:destination]).to eq "app/concepts/uluwatu/"
      end
      expect(Dir["./app/concepts/uluwatu/*"].empty?).to eq true
    end

    context "and concept already exist" do
      it "returns :failure signal" do
        expect {
          capture_stdout do
            signal, (ctx, *) = generate.call([{options: options, type: type, concept: concept}, {}])

            expect(signal).to eq described_class.outputs[:failure].signal
            expect(ctx[:destination]).to eq "app/concepts/uluwatu/"
          end
        }.to raise_error SystemExit
      end
    end
  end
end
