require "spec_helper"
require "./spec/trailblazer/generator/shared_example_for_activities"

RSpec.describe Trailblazer::Generator::GenerateFile do
  let(:context) do
    Trailblazer::Generator::Context.new(
      template: template,
      path: false,
      concept: "Blog",
      layout: "singular",
      name: "New",
      namespace: "Blog::Operation",
      namespace_path: "blog/operation",
      stubs: stubs,
      type: type
    )
  end
  let(:type) { :operation }
  let(:stubs) { "stubs" }
  let(:template) { "create" }
  let(:path) { Pathname.new("./app/concepts/blog/operation/new.rb") }

  subject(:generate_file) { described_class }

  it_behaves_like "the GenerateFile activity", described_class do
    let(:result) { generate_file.call([{context: context, type: type}, {}]) }
  end
end
