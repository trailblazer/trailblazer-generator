require "spec_helper"

RSpec.describe Trailblazer::Generator::Utils::Menu do
  before do
    2.times do |index|
      capture_stdout do
        Dir.mkdir("./app/concepts/blog#{index}")
      end
    end
  end

  subject(:menu) { described_class.new }

  pending "#overwrite"

  context "#abort" do
    it "returns a SustemExist" do
      expect { menu.abort }.to raise_error SystemExit
    end
  end
end
