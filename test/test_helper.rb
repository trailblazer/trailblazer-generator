$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'trailblazer/generator'

require 'minitest/autorun'

ClassName = Struct.new(:name)

class ClassName::Test < Trailblazer::Operation
  step Trailblazer::Generator::Macro::ValidateClassName()
end
