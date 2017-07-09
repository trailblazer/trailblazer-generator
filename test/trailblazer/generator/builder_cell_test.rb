require 'test_helper'
require 'fakefs/safe'

class Trailblazer::Generator::BuilderCellTest < Minitest::Test

  def test_build_cell_with_defautl_erb_view
    str_cell_new = <<~EOF
      module BlogPost::Cell
        class New < Trailblazer::Cell
          include ActionView::RecordIdentifier
          include ActionView::Helpers::FormOptionsHelper
        end
      end
    EOF

    str_cell_edit = <<~EOF
      module BlogPost::Cell
        class Edit < Trailblazer::Cell
        end
      end
    EOF

    str_cell_index = <<~EOF
      module BlogPost::Cell
        class Index < Trailblazer::Cell
          def total
            return "No element" if model.size == 0
          end
        end
      end
    EOF

    str_cell_item = <<~EOF
      module BlogPost::Cell
        class Item < Trailblazer::Cell
        end
      end
    EOF

    str_cell_show = <<~EOF
      module BlogPost::Cell
        class Show < Trailblazer::Cell
        end
      end
    EOF


    str_cell_custom = <<~EOF
      module BlogPost::Cell
        class Custom < Trailblazer::Cell
        end
      end
    EOF

    def view_file(model, model_underscore, action)
      <<~EOF
        <h1>#{model}##{action}</h1>
        <p>Find me in app/concepts/#{model_underscore}/view/#{action}.erb</p>
      EOF
    end


    Trailblazer::Generator::Builder::Cell.(name: "BlogPost", options: {"actions" => "new,edit,show,index,custom"})

    # cells files
    assert_equal str_cell_new, File.read('app/concepts/blog_post/cell/new.rb')
    assert_equal str_cell_edit, File.read('app/concepts/blog_post/cell/edit.rb')
    assert_equal str_cell_item, File.read('app/concepts/blog_post/cell/item.rb')
    assert_equal str_cell_index, File.read('app/concepts/blog_post/cell/index.rb')
    assert_equal str_cell_show, File.read('app/concepts/blog_post/cell/show.rb')
    assert_equal str_cell_custom, File.read('app/concepts/blog_post/cell/custom.rb')

    # view files
    assert_equal view_file("BlogPost", "blog_post", "new"), File.read('app/concepts/blog_post/view/new.erb')
    assert_equal view_file("BlogPost", "blog_post", "edit"), File.read('app/concepts/blog_post/view/edit.erb')
    assert_equal view_file("BlogPost", "blog_post", "index"), File.read('app/concepts/blog_post/view/index.erb')
    assert_equal view_file("BlogPost", "blog_post", "item"), File.read('app/concepts/blog_post/view/item.erb')
    assert_equal view_file("BlogPost", "blog_post", "show"), File.read('app/concepts/blog_post/view/show.erb')
    assert_equal view_file("BlogPost", "blog_post", "custom"), File.read('app/concepts/blog_post/view/custom.erb')

  end

end
