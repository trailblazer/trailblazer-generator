require "spec_helper"

RSpec.shared_examples "the GenerateFile activity" do |activity|
  let(:path) { Pathname.new("./app/concepts/blog/operation/new.rb") }
  let(:signal) { result.first }
  let(:ctx) { result.last.first }

  after { File.delete(path) if Pathname(path).exist? }

  it "creates a new operation using the create template" do
    capture_stdout do
      expect(signal).to eq activity.Outputs(:success)
      expect(ctx[:template][:file_name]).to eq Trailblazer::Generator::Utils::String.new(template)
      expect(ctx[:template][:path]).to eq File.join(Dir.pwd, "/lib/trailblazer/generator/stubs")
    end
    expect(Pathname(path).exist?).to eq true
    expect(File.read(path)).to include "class New < Trailblazer::Operation"
  end

  context "with default stubs and not existing template" do
    let(:template) { "weird" }

    it "creates a new operation using the generic template" do
      capture_stdout do
        expect(signal).to eq activity.Outputs(:success)
        expect(ctx[:template][:file_name]).to eq "generic"
        expect(ctx[:template][:path]).to eq File.join(Dir.pwd, "/lib/trailblazer/generator/stubs")
      end
      expect(Pathname(path).exist?).to eq true
      expect(File.read(path)).to include "class New < Trailblazer::Operation"
    end
  end

  context "when passing a custom stubs" do
    let(:stubs) { File.join(File.dirname(__dir__), "../stubs_test") }
    let(:template) { "weird_one" }

    it "creates a new operation using the custom stubs and template" do
      capture_stdout do
        expect(signal).to eq activity.Outputs(:success)
        expect(ctx[:template][:file_name]).to eq "weird_one"
        expect(ctx[:template][:path]).to eq File.join(Dir.pwd, "/spec/trailblazer/../stubs_test")
      end
      expect(Pathname(path).exist?).to eq true
      expect(File.read(path)).to include "class New < Trailblazer::Operation"
    end

    context "but a template is not found" do
      let(:template) { "not_found" }

      it "returns :missing_source end and does not create the file" do
        capture_stdout do
          expect(signal).to eq activity.Output(:missing_source)
        end
        expect(Pathname(path).exist?).to eq false
      end
    end
  end

  pending "when destination already exists returns :file_already_present - how do I pass input to terminal"
  pending "when file is not generated returns :failure" # need to understand how to pass inut to terminal first
end
