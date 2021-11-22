require "spec_helper"

RSpec.describe Trailblazer::Generator::CustomOptions do
  context "when the setting file does not exist" do
    it "returns successful" do
      signal, (_ctx, *) = described_class.call([{}, {}])

      expect(signal).to eq described_class.Output(:success)
    end
  end

  context "when the setting file exist" do
    let(:file_path) { "./spec/stubs_test/good_content.yml" }
    let(:generator) { Trailblazer::Generator }

    it "returns successful and custom_options hash" do
      signal, (ctx, *) = described_class.call([{file_path: file_path}, {}])

      expect(signal).to eq described_class.Output(:success)
      expect(ctx[:custom_options]).to eq(
        view: "slim",
        file_list: {
          cell: %w[custom custom2],
          operation: %w[new create]
        }
      )
    end

    it "overrides defual_options" do
      expect(generator.view).to eq "slim"
      expect(generator.stubs).to eq "stubs"
      expect(generator.add_type_to_namespace).to eq "true"
      expect(generator.app_folder).to eq "app"
      expect(generator.concepts_folder).to eq "concepts"

      expect(generator.file_list.operation).to eq %w[new create]
      expect(generator.file_list.cell).to eq %w[custom custom2]
      expect(generator.file_list.contract).to eq %w[create update]
      expect(generator.file_list.finder).to eq %w[list]
      expect(generator.file_list.view).to eq %w[]
    end

    context "but the file content is not an Hash" do
      let(:file_path) { "./spec/stubs_test/wrong_content.yml" }

      it "returns failure and warns the user about the wrong content" do
        result = capture_stdout do
          signal, (_ctx, *) = described_class.call([{file_path: file_path}, {}])

          expect(signal).to eq described_class.Output(:failure)
        end

        expect(result[:stdout]).to include "Warning"
      end
    end

    context "but the content validation fails" do
      let(:file_path) { "./spec/stubs_test/error_messages_test.yml" }

      it "returns failure and warns with the error messages" do
        result = capture_stdout do
          signal, (_ctx, *) = described_class.call([{file_path: file_path}, {}])

          expect(signal).to eq described_class.Output(:failure)
        end

        expect(result[:stdout]).to include "view must be a string, file_list: operation must be an array, cell must be an array"
      end
    end
  end
end
