require "spec_helper"

module Trailblazer
  class Generator
    describe VERSION do
      it "has a version number" do
        expect(Trailblazer::Generator::VERSION).to eq "0.3.0.pre"
      end
    end
  end
end
