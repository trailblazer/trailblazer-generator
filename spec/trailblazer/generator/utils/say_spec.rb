require "spec_helper"
require "pathname"

RSpec.describe Trailblazer::Generator::Utils::Say do
  subject(:say) { described_class.new }
  let(:pastel) { Pastel.new }

  context "#create" do
    let(:destination) { "./app/concepts/blog/cell/new.rb" }
    let(:output) { capture_stdout { say.create(destination) } }

    it "shows the creates message" do
      expect(output[:stdout]).to eq("\t#{pastel.green("Create")}:\t#{destination}\n")
    end
  end

  context "#notice" do
    let(:message) { "message" }
    let(:output) { capture_stdout { say.notice(message) } }

    it "shows the notice message" do
      expect(output[:stdout]).to eq("\t#{pastel.magenta("Notice")}:\t#{message}\n")
    end
  end

  context "#start" do
    let(:type) { "cell" }
    let(:output) { capture_stdout { say.start(type) } }

    it "shows the start message" do
      expect(output[:stdout]).to eq("\n    Starting Generator for Trailblazer #{type.capitalize}\n")
    end
  end

  context "#end" do
    let(:type) { "cell" }
    let(:output) { capture_stdout { say.end(type) } }

    it "shows the end message" do
      expect(output[:stdout]).to eq("    Ending Generator for Trailblazer #{type.capitalize}\n")
    end
  end

  context "#wrong_file_content" do
    let(:output) { capture_stdout { say.wrong_file_content } }

    it "shows the file found but wrong content" do
      expect(output[:stdout]).to include("trailblazer_generator.yml has been found but the content is not an Hash")
    end

    context "when passing a custom message" do
      let(:output) { capture_stdout { say.wrong_file_content("message") } }

      it "shows the custom message" do
        expect(output[:stdout]).to include("trailblazer_generator.yml has been found but message")
      end
    end
  end

  context "#close" do
    let(:type) { "cell" }
    let(:output) { capture_stdout { say.close } }

    it "add a new line character" do
      expect(output[:stdout]).to eq("\n")
    end
  end
end
