require "spec_helper"
require "pathname"

RSpec.describe Trailblazer::Generator::Utils::Files do
  let(:context) do
    Trailblazer::Generator::Context.new(
      action: "new",
      path: false,
      concept: "Blog",
      layout: "singular",
      name: "New",
      concept_path: "blog",
      type: type
    )
  end
  let(:type) { :operation }

  subject(:files) { described_class }

  context "#generate" do
    let(:output) { capture_stdout { files.generate(context, type) } }
    let(:path) { Pathname.new("./app/concepts/blog/operation/new.rb") }

    it "creates a new operation file with the correct content" do
      output

      expect(Pathname(path).exist?).to eq true
      expect(File.read(path)).to include "class New < Trailblazer::Operation"
    end
  end

  context "#write" do
    let(:source) { Pathname.new("./lib/trailblazer/generator/stubs/cell/edit.erb") }
    let(:destination) { Pathname.new("./app/concepts/blog/operation/some.rb") }

    it "creates a new file" do
      files.write(source, destination, context)

      expect(Pathname(destination).exist?).to eq true
    end
  end

  context "#mkdir" do
    let(:destination) { Pathname.new("./app/concepts/some_weird_one") }
    let(:output) { capture_stdout { files.mkdir(destination) } }

    context "when destination does not exist already" do
      it "creates a new folder and return Say create message" do
        expect(output[:stdout]).to include "./app/concepts/some_weird_one"
        expect(Pathname(destination).exist?).to eq true
      end
    end

    context "when destination already exists" do
      let(:destination) { Pathname.new("./app/concepts/post") }

      it "returns an error" do
        expect { output }.to raise_error SystemExit
      end
    end
  end

  context "#exists?" do
    it "returns true when finds the path" do
      expect(files.exist?(Pathname.new("./lib/trailblazer/generator"))).to eq true
    end

    it "returns false when does not find the path" do
      expect(files.exist?(Pathname.new("./some_weird_one"))).to eq false
    end
  end

  context "#get_files" do
    let(:path) { Pathname.new("./lib") }

    it "returns the list of the files names" do
      expect(files.get_files(path)).to eq ["./lib/trailblazer/"]
    end
  end

  context "#get_file_name" do
    let(:path) { Pathname.new("./app/concepts/post/operation/new.rb") }

    it "returns file name" do
      expect(files.get_file_name(path)).to eq "new.rb"
    end
  end
end
