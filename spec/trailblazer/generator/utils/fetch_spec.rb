require "spec_helper"
require "pathname"

RSpec.describe Trailblazer::Generator::Utils::Fetch do
  subject(:fetch) { described_class }

  before do
    Trailblazer::Generator.enable_test_interface
    Trailblazer::Generator.reset_config
  end

  context "#option" do
    let(:options) { {name: "name"} }

    it "returns option value if exists" do
      expect(fetch.option(options, :name)).to eq "name"
      expect(fetch.option(options, :layout)).to eq false
    end
  end

  context "#context" do
    let(:concept) { "Blog" }
    let(:concept_path) { Trailblazer::Generator::Utils::String.underscore(concept) }
    let(:concept_in_string) { concept }
    let(:type) { :type }
    let(:type_in_string) { type.to_s }
    let(:view_in_string) { view.to_s }
    let(:view) { "erb" }
    let(:stubs) { "stubs" }
    let(:stubs_in_string) { stubs }
    let(:namespace) { "Blog::Type" }
    let(:namespace_path) { "blog/type" }

    subject(:context) { fetch.context(options, type, concept) }

    context "default options" do
      let(:options) { {} }
      let(:default_options) do
        {
          concept: concept, template: false, path: false, type: type_in_string, name: false, json: false,
          view: view_in_string, stubs: stubs, namespace: namespace, namespace_path: namespace_path,
          activity_strategy: false
        }
      end
      let(:default_context) { Trailblazer::Generator::Context.new(default_options) }

      it "creates a new Context object with default options" do
        expect(context).to eq default_context
      end
    end

    context "when passing layout as plural" do
      let(:options) { {layout: "plural"} }
      let(:type_in_string) { "#{type}s" }
      let(:namespace) { "Blog::Types" }
      let(:namespace_path) { "blog/types" }
      let(:custom_options) do
        {
          concept: concept, template: false, path: false, type: type_in_string, name: false, json: false,
          view: view_in_string, stubs: stubs, namespace: namespace, namespace_path: namespace_path,
          activity_strategy: false
        }
      end
      let(:custom_context) { Trailblazer::Generator::Context.new(custom_options) }

      it "creates a custom Context object with custom options" do
        expect(context).to eq custom_context
      end
    end

    context "when passing an template and the name" do
      let(:options) { {template: "new", name: "SomeName"} }
      let(:custom_options) do
        {
          concept: concept, template: "new", path: false, type: type_in_string, name: "SomeName", json: false,
          view: view_in_string, stubs: stubs, namespace: namespace, namespace_path: namespace_path,
          activity_strategy: false
        }
      end
      let(:custom_context) { Trailblazer::Generator::Context.new(custom_options) }

      it "creates a custom Context object with custom options" do
        expect(context).to eq custom_context
      end
    end

    context "when passing only name" do
      let(:options) { {name: "SomeName"} }
      let(:custom_options) do
        {
          concept: concept, template: "some_name", path: false, type: type_in_string, name: "SomeName", json: false,
          view: view_in_string, stubs: stubs, namespace: namespace, namespace_path: namespace_path,
          activity_strategy: false
        }
      end
      let(:custom_context) { Trailblazer::Generator::Context.new(custom_options) }

      it "creates a custom Context object with custom options" do
        expect(context).to eq custom_context
      end
    end

    context "when passing custom stubs" do
      let(:options) { {stubs: "some_stubs"} }
      let(:stubs) { "some_stubs" }
      let(:custom_options) do
        {
          concept: concept, template: false, path: false, type: type_in_string, name: false, json: false,
          view: view_in_string, stubs: stubs, namespace: namespace, namespace_path: namespace_path,
          activity_strategy: false
        }
      end
      let(:custom_context) { Trailblazer::Generator::Context.new(custom_options) }

      it "creates a custom Context object with custom options" do
        expect(context).to eq custom_context
      end
    end

    context "when passing a view type" do
      let(:view) { "erb" }
      let(:options) { {view: view} }
      let(:custom_options) do
        {
          concept: concept, template: false, path: false, type: type_in_string, name: false, json: false,
          view: view_in_string, stubs: stubs, namespace: namespace, namespace_path: namespace_path,
          activity_strategy: false
        }
      end
      let(:custom_context) { Trailblazer::Generator::Context.new(custom_options) }

      it "creates a custom Context object with custom options" do
        expect(context).to eq custom_context
      end
    end

    context "when passing json", skip: "Disabling this as we have excluded the other related features until we're satisfied" do
      let(:json) { Pathname.new("./test.json") }
      let(:options) { {json: json} }
      let(:json_parsed) { Trailblazer::Generator::Utils::Parse.json(json) }
      let(:custom_options) do
        {
          concept: nil, template: false, path: false, type: type_in_string, name: false, json: json_parsed,
          view: view_in_string, stubs: stubs, namespace: namespace, namespace_path: namespace_path,
          activity_strategy: false
        }
      end
      let(:custom_context) { Trailblazer::Generator::Context.new(custom_options) }

      it "creates a custom Context object with custom options" do
        expect(context).to eq custom_context
      end
    end
  end

  context "#concept" do
    let(:concept) { "BlogPost" }

    context "when concept class folder does not exist" do
      it "creates a new folder and return concept" do
        output = capture_stdout do
          expect(fetch.concept(concept, nil, nil)).to eq "BlogPost"
        end

        expect(output[:stdout]).to include "app/concepts/blog_post"
        expect(Pathname("./app/concepts/blog_post").exist?).to eq true
      end
    end

    context "when concept class folder already exist" do
      before { capture_stdout { fetch.concept(concept, nil, nil) } }

      it "returns concept whitout creating a new folder " do
        output = capture_stdout do
          expect(fetch.concept(concept, nil, nil)).to eq "BlogPost"
        end

        expect(output[:stdout]).to eq ""
      end
    end
  end

  context "#namespace" do
    let(:options) { {add_type_to_namespace: add_type_to_namespace?} }
    let(:add_type_to_namespace?) { true }

    subject(:namespace) { described_class.namespace(options, "Blog", "type") }

    it { is_expected.to eq "Blog::Type" }

    context "when add_type_to_namespace is false" do
      let(:add_type_to_namespace?) { false }

      it { is_expected.to eq "Blog" }
    end
  end

  context "#activity_strategy" do
    let(:activity_strategy) { %w[path fast_track railway].freeze }
    let(:activity_strategy_module) { %w[Path FastTrack Railway].freeze }
    let(:options) { {activity_strategy: activity_strategy} }

    it "returns capitalized strategy" do
      activity_strategy.each_with_index do |strategy, index|
        expect(
          described_class.activity_strategy(strategy)
        ).to eq activity_strategy_module[index]
      end
    end

    context "when passing a unsupported strategy" do
      it "shows a notice message and uses Path" do
        output = capture_stdout do
          activity_strategy = described_class.activity_strategy("random")

          expect(activity_strategy).to eq "Path"
        end

        expect(output[:stdout]).to include "random is not a supported activity strategy"
      end
    end

    context "when option is false" do
      it "returns false" do
        expect(described_class.activity_strategy(false)).to eq false
      end
    end
  end
end
