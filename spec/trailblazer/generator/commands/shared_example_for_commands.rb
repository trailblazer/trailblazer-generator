require "spec_helper"

RSpec.shared_examples "a multiple files generation command" do |desc_class, command, type, check_view = false|
  let(:concept) { "SharedExamplesMultiFile" }

  let(:run_command) do
    capture_stdout do
      desc_class.new(command_name: command).call(options.merge(concept: concept))
    end
  end

  context "able to use --app_dir" do
    let(:options) { {app_dir: "custom"} }

    it "to generate files in a different folder" do
      expect(run_command[:stdout]). to include "Starting Generator for Trailblazer #{type.capitalize}"
      expect(run_command[:stdout]). to include "Starting Generator for Trailblazer View" if check_view

      Trailblazer::Generator.file_list.public_send(type).each do |template|
        file = Pathname.new("./custom/concepts/shared_examples_multi_file/#{type}/#{template}.rb")
        expect(Pathname(file).exist?).to eq true

        if check_view
          view_file = Pathname.new("./custom/concepts/shared_examples_multi_file/view/#{template}.erb")
          expect(Pathname(view_file).exist?).to eq true
        end
      end
    end
  end

  context "able to use --concepts_folder" do
    let(:options) { {concepts_folder: "custom"} }

    it "to generate files in a different folder" do
      expect(run_command[:stdout]). to include "Starting Generator for Trailblazer #{type.capitalize}"
      expect(run_command[:stdout]). to include "Starting Generator for Trailblazer View" if check_view

      Trailblazer::Generator.file_list.public_send(type).each do |template|
        file = Pathname.new("./app/custom/shared_examples_multi_file/#{type}/#{template}.rb")
        expect(Pathname(file).exist?).to eq true

        if check_view
          view_file = Pathname.new("./app/custom/shared_examples_multi_file/view/#{template}.erb")
          expect(Pathname(view_file).exist?).to eq true
        end
      end
    end
  end
end
