module Trailblazer
  module Generator
    class Generate < Thor
    end
  end
end

require 'trailblazer/generator/cli/generate/cell'
require 'trailblazer/generator/cli/generate/contract'
require 'trailblazer/generator/cli/generate/operation'
