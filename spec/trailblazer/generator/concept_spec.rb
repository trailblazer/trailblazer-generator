require "spec_helper"
require "pathname"

RSpec.describe Trailblazer::Generator::Concept do
  subject(:concept) { described_class }

  context "#root" do
    it { expect(concept.root).to eq "app/concepts/" }
  end

  context "#dir" do
    it { expect(concept.dir("post")).to eq "app/concepts/post/" }
  end

  context "#exits?" do
    it { expect(concept.exists?("post")).to eq true }
    it { expect(concept.exists?("some_weird_stuff")).to eq false }
  end

  context "#concepts" do
    it { expect(concept.concepts).to eq Dir.glob("app/concepts/**/*/") }
  end

  context "#generate" do
    let(:destination) { Pathname.new("./app/new_post") }

    it "creates a new folder in destination" do
      capture_stdout { concept.generate(destination) }

      expect(Pathname(destination).exist?).to eq true
    end
  end

  context "#destination" do
    let(:type) { "some_type" }
    let(:view) { false }
    let(:path) { false }
    let(:context) do
      OpenStruct.new(
        path: path, concept: "Blog", layout: "singular", name: "Create", concept_path: "blog",
        type: type, view: view
      )
    end

    it { expect(concept.destination(context)).to eq "app/concepts/blog/some_type/create.rb" }

    context "when context has path" do
      let(:path) { "some_path" }

      it { expect(concept.destination(context)).to eq "some_path/blog/some_type/create.rb" }
    end

    context "when context has view and type is view" do
      let(:type) { "view" }
      let(:view) { "slim" }

      it { expect(concept.destination(context)).to eq "app/concepts/blog/view/create.slim" }
    end
  end
end
