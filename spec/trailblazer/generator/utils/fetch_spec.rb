require "spec_helper"
require "pathname"

RSpec.describe Trailblazer::Generator::Utils::Fetch do
  subject(:fetch) { described_class }

  context "#option" do
    let(:options) { {name: "name"} }

    it "returns option value if exists" do
      expect(fetch.option(options, :name)).to eq "name"
      expect(fetch.option(options, :layout)).to eq false
    end
  end

  context "#context" do
    let(:concept) { nil }
    let(:concept_path) { Trailblazer::Generator::Utils::String.underscore(concept) }
    let(:concept_in_string) { Trailblazer::Generator::Utils::String.new(concept) }
    let(:type) { :some_type }
    let(:type_in_string) { Trailblazer::Generator::Utils::String.new(type) }
    let(:view_in_string) { Trailblazer::Generator::Utils::String.new(view) }
    let(:view) { "slim" }
    let(:stubs) { "../stubs" }
    let(:stubs_in_string) { Trailblazer::Generator::Utils::String.new(stubs) }

    subject(:context) { fetch.context(options, type) }

    context "default options" do
      let(:options) { {} }
      let(:default_options) do
        {
          concept: nil, template: false, path: false, type: type_in_string, name: false, json: false,
          concept_path: concept_path, view: view_in_string, stubs: stubs
        }
      end
      let(:default_context) { Trailblazer::Generator::Context.new(default_options) }

      it "creates a new Context object with default options" do
        expect(context).to eq default_context
      end
    end

    context "when passing layout as plural" do
      let(:options) { {layout: "plural"} }
      let(:type_in_string) { Trailblazer::Generator::Utils::String.new("#{type}s") }
      let(:custom_options) do
        {
          concept: nil, template: false, path: false, type: type_in_string, name: false, json: false,
          concept_path: concept_path, view: view_in_string, stubs: stubs
        }
      end
      let(:custom_context) { Trailblazer::Generator::Context.new(custom_options) }

      it "creates a custom Context object with custom options" do
        expect(context).to eq custom_context
      end
    end

    context "when passing a concept" do
      let(:concept) { "BlogPost::Post" }
      let(:custom_options) do
        {
          concept: concept_in_string, template: false, path: false, type: type_in_string, name: false, json: false,
          concept_path: concept_path, view: view_in_string, stubs: stubs
        }
      end
      let(:custom_context) { Trailblazer::Generator::Context.new(custom_options) }

      it "creates a new Context object with default options" do
        expect(fetch.context({}, type, concept)).to eq custom_context
      end
    end

    context "when passing an template and the name" do
      let(:options) { {template: "new", name: "SomeName"} }
      let(:custom_options) do
        {
          concept: nil, template: "new", path: false, type: type_in_string, name: "SomeName", json: false,
          concept_path: concept_path, view: view_in_string, stubs: stubs
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
          concept: nil, action: "some_name", path: false, type: type_in_string, name: "SomeName", json: false,
          concept_path: concept_path, view: false, stubs: stubs
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
          concept: nil, action: false, path: false, type: type_in_string, name: false, json: false,
          concept_path: concept_path, view: false, stubs: stubs
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
          concept: nil, template: false, path: false, type: type_in_string, name: false, json: false,
          concept_path: concept_path, view: view_in_string, stubs: stubs
        }
      end
      let(:custom_context) { Trailblazer::Generator::Context.new(custom_options) }

      it "creates a custom Context object with custom options" do
        expect(context).to eq custom_context
      end
    end

    # Disabling this as we have excluded the other related features until we're satisfied
    # context "when passing json" do
    #   let(:json) { Pathname.new("./test.json") }
    #   let(:options) { {json: json} }
    #   let(:json_parsed) { Trailblazer::Generator::Utils::Parse.json(json) }
    #   let(:custom_options) do
    #     {
    #       concept: nil, template: false, path: false, type: type_in_string, name: false, json: json_parsed,
    #       concept_path: concept_path, view: false
    #     }
    #   end
    #   let(:custom_context) { Trailblazer::Generator::Context.new(custom_options) }

    #   it "creates a custom Context object with custom options" do
    #     expect(context).to eq custom_context
    #   end
    # end
  end

  context "#concept" do
    let(:concept) { "BlogPost" }

    context "when concept class folder does not exist" do
      it "creates a new folder and return concept" do
        output = capture_stdout do
          expect(fetch.concept(concept)).to eq "BlogPost"
        end

        expect(output[:stdout]).to include "app/concepts/blog_post"
        expect(Pathname("./app/concepts/blog_post").exist?).to eq true
      end
    end

    context "when concept class folder already exist" do
      before { capture_stdout { fetch.concept(concept) } }

      it "returns concept whitout creating a new folder " do
        output = capture_stdout do
          expect(fetch.concept(concept)).to eq "BlogPost"
        end

        expect(output[:stdout]).to eq ""
      end
    end
  end
end
