require "spec_helper"

RSpec.shared_examples "a single file generation command" do |desc_class, type, check_view = false|
  let(:concept) { "SharedExample" }
  let(:template_array) { Trailblazer::Generator.file_list.public_send(type) }
  let(:template) { template_array.sample }

  before do
    singular = "./app/concepts/shared_example/#{type}"
    plural = "./app/concepts/shared_example/#{type}s"
    singular_view = "./app/concepts/shared_example/view"
    plural_view = "./app/concepts/shared_example/view"
    FileUtils.remove_dir(singular) if Pathname(singular).exist?
    FileUtils.remove_dir(plural) if Pathname(plural).exist?
    FileUtils.remove_dir(singular_view) if Pathname(singular_view).exist?
    FileUtils.remove_dir(plural_view) if Pathname(plural_view).exist?
  end

  let(:run_command) do
    capture_stdout do
      desc_class.new(command_name: type).call(options.merge(concept: concept))
    end
  end

  context "generates file from template" do
    let(:options) { {name: template.capitalize} }
    let(:file) { Pathname.new("./app/concepts/shared_example/#{type}/#{template}.rb") }

    it "and shows create messages" do
      expect(run_command[:stdout]).to include "Starting Generator for Trailblazer #{type.capitalize}"
      expect(run_command[:stdout]).to include "Create"
      expect(run_command[:stdout]).to include "app/concepts/shared_example/#{type}/#{template}.rb"
      expect(Pathname(file).exist?).to eq true
    end
  end

  context "generates file from generic template" do
    let(:options) { {name: "SomeWeirdOne"} }
    let(:file) { Pathname.new("./app/concepts/shared_example/#{type}/some_weird_one.rb") }

    it "and shows create and notice messages" do
      expect(run_command[:stdout]).to include "Starting Generator for Trailblazer #{type.capitalize}"
      expect(run_command[:stdout]).to include "Create"
      expect(run_command[:stdout]).to include "app/concepts/shared_example/#{type}/some_weird_one.rb"
      expect(run_command[:stdout]).to include "Notice"
      expect(run_command[:stdout]).to include "Templete file some_weird_one not found - a generic templete has been used"
      expect(Pathname(file).exist?).to eq true
    end
  end

  context "generates file from template using --template option" do
    let(:another_template) { template_array.sample }
    let(:options) { {name: template.capitalize, template: another_template} }
    let(:file) { Pathname.new("./app/concepts/shared_example/#{type}/#{template}.rb") }

    it "and shows create messages" do
      expect(run_command[:stdout]).to include "Starting Generator for Trailblazer #{type.capitalize}"
      expect(run_command[:stdout]).to include "Create"
      expect(run_command[:stdout]).to include "app/concepts/shared_example/#{type}/#{template}.rb"
      expect(Pathname(file).exist?).to eq true
    end
  end

  context "able to use the --layout option" do
    let(:options) { {name: template.capitalize, layout: "plural"} }
    let(:file) { Pathname.new("./app/concepts/shared_example/#{type}s/#{template}.rb") }

    it "to generate files in plural concepts folders" do
      expect(run_command[:stdout]).to include "Starting Generator for Trailblazer #{type.capitalize}"
      expect(run_command[:stdout]).to include "Create"
      expect(run_command[:stdout]).to include "app/concepts/shared_example/#{type}s/#{template}.rb"
      expect(Pathname(file).exist?).to eq true
    end
  end

  context "able to use --stubs to set a different template path" do
    let(:stubs) { File.join(File.dirname(__dir__), "../../stubs_test") }
    let(:options) { {name: "WeirdOne", stubs: stubs} }
    let(:file_path) { "app/concepts/shared_example/#{type}/weird_one.rb" }

    it "to generate files from a different set of templates" do
      expect(run_command[:stdout]).to include "Starting Generator for Trailblazer #{type.capitalize}"
      expect(run_command[:stdout]).to include "Create"
      expect(run_command[:stdout]).to include file_path
      expect(File.read(file_path)).to include "def custom_stuff"
      expect(Pathname(file_path).exist?).to eq true
    end
  end

  if check_view
    context "when passing --view option creates the view file" do
      let(:options) { {name: "New", view: "slim"} }
      let(:file) { Pathname.new("./app/concepts/shared_example/view/new.slim") }

      it "and shows create messages" do
        expect(run_command[:stdout]).to include "Starting Generator for Trailblazer View"
        expect(run_command[:stdout]).to include "Create"
        expect(run_command[:stdout]).to include "app/concepts/shared_example/view/new.slim"
        expect(Pathname(file).exist?).to eq true
      end
    end
  end

  context "when passing the wrong concept format" do
    let(:concept) { "yeah_nah" }
    let(:options) { {name: template.capitalize} }

    it "fails and shows error message" do
      expect { run_command }.to raise_error SystemExit, /You provided an invalid class name - #{concept}/
    end
  end

  context "when passing the wrong class name" do
    let(:options) { {name: "yeah_nah"} }

    it "fails and shows error message" do
      expect { run_command }.to raise_error SystemExit, /You provided an invalid class name - yeah_nah/
    end
  end

  context "when source file is not found" do
    let(:options) { {name: template.capitalize, stubs: "not_existing_one"} }

    it "fails and shows error message" do
      expect { run_command }.to raise_error SystemExit, /No source file found/
    end
  end
end
