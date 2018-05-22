require "spec_helper"

RSpec.shared_examples "a single file generation command" do |type, check_view = false|
  let(:concept) { "SharedExample" }
  let(:template_array) { Trailblazer::Generator::Utils::Files::DEFAULT_MAP[type.to_sym] }
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

  context "generates file from template" do
    let(:run_command) { `bin/trailblazer g #{type} #{concept} #{template.capitalize}` }
    let(:file) { Pathname.new("./app/concepts/shared_example/#{type}/#{template}.rb") }

    it "and shows create messages" do
      expect(run_command).to include "Starting Generator for Trailblazer #{type.capitalize}"
      expect(run_command).to include "Create"
      expect(run_command).to include "app/concepts/shared_example/#{type}/#{template}.rb"
      expect(Pathname(file).exist?).to eq true
    end
  end

  context "generates file from generic template" do
    let(:name) { "SomeWeirdOne" }
    let(:run_command) { `bin/trailblazer g #{type} #{concept} #{name}` }
    let(:file) { Pathname.new("./app/concepts/shared_example/#{type}/some_weird_one.rb") }

    it "and shows create and notice messages" do
      expect(run_command).to include "Starting Generator for Trailblazer #{type.capitalize}"
      expect(run_command).to include "Create"
      expect(run_command).to include "app/concepts/shared_example/#{type}/some_weird_one.rb"
      expect(run_command).to include "Notice"
      expect(run_command).to include "Templete file some_weird_one not found - a generic templete has been used"
      expect(Pathname(file).exist?).to eq true
    end
  end

  context "generates file from template using --template option" do
    let(:another_template) { template_array.sample }
    let(:run_command) { `bin/trailblazer g #{type} #{concept} #{template.capitalize} --template=#{another_template}` }
    let(:file) { Pathname.new("./app/concepts/shared_example/#{type}/#{template}.rb") }

    it "and shows create messages" do
      expect(run_command).to include "Starting Generator for Trailblazer #{type.capitalize}"
      expect(run_command).to include "Create"
      expect(run_command).to include "app/concepts/shared_example/#{type}/#{template}.rb"
      expect(Pathname(file).exist?).to eq true
    end
  end

  context "able to use the --layout option" do
    let(:run_command) { `bin/trailblazer g #{type} #{concept} #{template.capitalize} --layout=plural` }
    let(:file) { Pathname.new("./app/concepts/shared_example/#{type}s/#{template}.rb") }

    it "to generate files in plural concepts folders" do
      expect(run_command).to include "Starting Generator for Trailblazer #{type.capitalize}"
      expect(run_command).to include "Create"
      expect(run_command).to include "app/concepts/shared_example/#{type}s/#{template}.rb"
      expect(Pathname(file).exist?).to eq true
    end
  end
  
  context "able to use --stubs to set a different template path" do
    let(:root_path) { File.join(File.dirname(__dir__), "../../stubs_test") }
    let(:run_command) { `bin/trailblazer g #{type} #{concept} WeirdOne --stubs=#{root_path}` }
    let(:file_path) { "app/concepts/shared_example/#{type}/weird_one.rb" }

    it "to generate files from a different set of templates" do
      expect(run_command).to include "Starting Generator for Trailblazer #{type.capitalize}"
      expect(run_command).to include "Create"
      expect(run_command).to include file_path
      expect(File.read(file_path)).to include "def custom_stuff"
      expect(Pathname(file_path).exist?).to eq true
    end
  end
  
  if check_view
    context "when passing --view option creates the view file" do
      let(:run_command) { `bin/trailblazer g cell SharedExample New --view=slim` }
      let(:file) { Pathname.new("./app/concepts/shared_example/view/new.slim") }

      it "and shows create messages" do
        expect(run_command).to include "Starting Generator for Trailblazer View"
        expect(run_command).to include "Create"
        expect(run_command).to include "app/concepts/shared_example/view/new.slim"
        expect(Pathname(file).exist?).to eq true
      end
    end
  end
end
