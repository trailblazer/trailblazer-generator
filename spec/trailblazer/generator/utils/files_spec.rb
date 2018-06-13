require "spec_helper"
require "pathname"

RSpec.describe Trailblazer::Generator::Utils::Files do
  subject(:files) { described_class }

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
