require 'test_helper'
require 'fakefs/safe'

class Trailblazer::Generator::BuilderCellTest < Minitest::Test

  def test_build_cell_with_defautl_erb_view
    str = <<~EOF
      module BlogPost::Cell
        class New < Trailblazer::Cell
        end
      end
    EOF

    Trailblazer::Generator::Builder::Cell.(name: "BlogPost", options: {action: "new"})

    assert_equal str, File.read('app/concepts/blog_post/cell/new.rb')
  end

end
