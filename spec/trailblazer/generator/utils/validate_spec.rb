require "spec_helper"

RSpec.describe Trailblazer::Generator::Utils::Validate do
  subject(:validate) { described_class.new }

  context "#concept_name" do
    it "for correct class names" do
      %w[Report::Create Report RePort].each do |concept|
        expect(
          capture_stdout { validate.concept_name(concept) }
        ).to eq(stdout: "", stderr: "")
      end
    end

    context "for invalid class names" do
      it "raises the class_name error" do
        %w[report 1234].each do |concept|
          expect { capture_stdout { validate.concept_name(concept) } }.to raise_error SystemExit
        end
      end
    end
  end

  context "#class_name" do
    it "for correct class names" do
      %w[Report RePort].each do |concept|
        expect(
          capture_stdout { validate.class_name(concept) }
        ).to eq(stdout: "", stderr: "")
      end
    end

    context "for invalid class names" do
      it "raises the class_name error" do
        %w[report 1234].each do |concept|
          expect { capture_stdout { validate.class_name(concept) } }.to raise_error SystemExit
        end
      end
    end
  end

  context "#source" do
    let(:source) { Pathname.new("./lib/trailblazer/generator/stubs/cell/edit.erb") }

    it "for an existing source path" do
      expect(
        capture_stdout { validate.source(source) }
      ).to eq(stdout: "", stderr: "")
    end

    context "when source is not found" do
      let(:source) { Pathname.new("./lib/some_weird_one") }

      it "raises the souce error" do
        expect { capture_stdout { validate.source(source) } }.to raise_error SystemExit
      end
    end
  end

  context "#destination" do
    let(:destination) { "./lib/trailblazer/generator/stubs/cell/edit.erb" }
    let(:output) { capture_stdout { validate.destination(destination) } }
    let(:menu_class) { Trailblazer::Generator::Utils::Menu }

    before { allow_any_instance_of(menu_class).to receive(:overwrite).and_return(true) }

    it "for an existing destination path" do
      expect_any_instance_of(menu_class).to receive(:overwrite).with(destination)

      output
    end

    context "when destination is not found" do
      let(:destination) { "./lib/some_weird_one/new.rb" }

      it "raises the souce error" do
        expect(output[:stdout]).to eq "\t\e[32mCreate\e[0m:\t#{destination}\n"
      end
    end
  end

  context "#write" do
    let(:destination) { "./lib/trailblazer/generator/stubs/cell/edit.erb" }

    it "when destination path exists" do
      expect(
        capture_stdout { validate.write(destination) }
      ).to eq(stdout: "", stderr: "")
    end

    context "when destination path is not found" do
      let(:destination) { Pathname.new("./lib/some_weird_one") }

      it "raises the souce error" do
        expect { capture_stdout { validate.write(destination) } }.to raise_error SystemExit
      end
    end
  end
end
