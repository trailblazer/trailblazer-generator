require "spec_helper"

RSpec.describe Trailblazer::Generator::Utils::Ask do
  let(:menu_class) { Trailblazer::Generator::Utils::Menu }
  subject(:ask) { described_class.new }

  before { allow_any_instance_of(menu_class).to receive(:overwrite).and_return(true) }

  context "#overwrite?" do
    it "calls Menu overwrite" do
      expect_any_instance_of(menu_class).to receive(:overwrite).with("post")

      ask.overwrite?("post")
    end
  end
end
