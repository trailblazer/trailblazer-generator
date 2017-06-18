require 'test_helper'
require 'fakefs/safe'

class Trailblazer::Generator::OutputTest < Minitest::Test
  def test_generate_correct_file
    str = <<~EOF
      class Thing::Create < Trailblazer::Operation
      end
    EOF
    FakeFS do
      Trailblazer::Generator::Output.new(path: 'app/concepts/operation/create.rb', content: str).save

      assert_equal str, File.read('app/concepts/operation/create.rb')
    end
  end
end
