require "spec_helper"

RSpec.describe "bin/trailblazer" do
  it "calls version command" do
    output = `bin/trailblazer version`
    expect(output).to eq("Trailblazer-Generator 0.10.0.pre\n")
  end

  it "calls version command with alias v" do
    output    = `bin/trailblazer v`
    expected  = "Trailblazer-Generator 0.10.0.pre\n"
    expect(output).to eq(expected)
  end

  it "calls version command with alias -v" do
    output    = `bin/trailblazer -v`
    expected  = "Trailblazer-Generator 0.10.0.pre\n"
    expect(output).to eq(expected)
  end

  it "calls version command with alias --version" do
    output    = `bin/trailblazer --version`
    expected  = "Trailblazer-Generator 0.10.0.pre\n"
    expect(output).to eq(expected)
  end

  it "calls help command" do
    output = `bin/trailblazer --help`
    expect(output).to include("Commands:\n")
    expect(output).to include("version\n")
  end
end
