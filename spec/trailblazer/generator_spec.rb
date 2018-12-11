require "spec_helper"

RSpec.describe Trailblazer::Generator do
  subject(:generator) { described_class }

  # this is required otherwise the changes applied in CustomOptions will make this test fails
  before do
    Trailblazer::Generator.enable_test_interface
    Trailblazer::Generator.reset_config
  end

  it "has a version number" do
    expect(generator::VERSION).to eq "0.3.0.pre"
  end

  it "default_options" do
    expect(generator.view).to eq "erb"
    expect(generator.stubs).to eq "stubs"
    expect(generator.add_type_to_namespace).to eq "true"
    expect(generator.app_folder).to eq "app"
    expect(generator.concepts_folder).to eq "concepts"

    expect(generator.file_list.operation).to eq %w[index create update delete show]
    expect(generator.file_list.cell).to eq %w[index item new edit show]
    expect(generator.file_list.contract).to eq %w[create update]
    expect(generator.file_list.finder).to eq %w[list]
    expect(generator.file_list.view).to eq %w[]
  end
end
