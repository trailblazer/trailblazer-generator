require "spec_helper"
require "pathname"

RSpec.describe Trailblazer::Generator::Utils::Error do
  subject(:error) { described_class.new }
  let(:context) { "post" }
  let(:path) { "./app/post" }
  let(:pastel) { Pastel.new }

  context "#source" do
    let(:output) { capture_stdout { error.source(Pathname.new(path)) } }

    it "raises the error with a source error message" do
      expect { output }.to raise_error SystemExit,
        "\t#{pastel.red("Error")}:\t#{context.to_s.ljust(55, " ")} - No source file found"\
        "\n\t\tPlease create it or notify the developers\n\n"\
    end
  end

  context "#exist" do
    let(:output) { capture_stdout { error.exist(Pathname.new("./app/post")) } }

    it "raises the error with a exist error message" do
      expect { output }.to raise_error SystemExit, "\t#{pastel.red("Exist")}:\t#{path}\n\n"
    end
  end

  context "#write" do
    let(:output) { capture_stdout { error.write(Pathname.new("./app/post")) } }

    it "raises the error with a exist error message" do
      expect { output }.to raise_error SystemExit, "\n\t#{pastel.red("Error")}:\tWhile trying to (over)write #{path}\n\n"
    end
  end

  context "#class_name" do
    let(:output) { capture_stdout { error.class_name("report") } }

    it "raises the error with a exist error message" do
      expect { output }.to raise_error SystemExit, "\n\t#{pastel.red("Error")}:\tYou provided an invalid class name - report\n\n"
    end
  end
end
