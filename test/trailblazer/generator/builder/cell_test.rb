require 'test_helper'
require 'fakefs/safe'

class Trailblazer::Generator::Builder::CellTest < Minitest::Test

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

    cell_files = [str_cell_new, str_cell_edit, str_cell_show, str_cell_index, str_cell_item, str_cell_custom]

    cell_paths = [
                    "app/concepts/blog_post/cell/new.rb",
                    "app/concepts/blog_post/cell/edit.rb",
                    "app/concepts/blog_post/cell/show.rb",
                    "app/concepts/blog_post/cell/index.rb",
                    "app/concepts/blog_post/cell/item.rb",
                    "app/concepts/blog_post/cell/custom.rb"
                  ]

    def view_file(action)
      <<~EOF
        <h1>BlogPost##{action}</h1>
        <p>Find me in app/concepts/blog_post/view/#{action}.erb</p>
      EOF
    end

    view_paths = [
                  "app/concepts/blog_post/view/new.erb",
                  "app/concepts/blog_post/view/edit.erb",
                  "app/concepts/blog_post/view/show.erb",
                  "app/concepts/blog_post/view/index.erb",
                  "app/concepts/blog_post/view/custom.erb",
                  "app/concepts/blog_post/view/item.erb"
                ]

    result = Trailblazer::Generator::Builder::Cell.(name: "BlogPost", options: {"actions" => "new,edit,show,index,custom", "debug" => true})
    # cells files
    cell_files.zip(result["cell_result"]["files_content"]).each do |cell_file, cell_file_result|
      assert_equal cell_file, cell_file_result
    end

    # cells paths
    cell_paths.zip(result["cell_result"]["files_path"]).each do |cell_path, cell_path_result|
      assert_equal cell_path, cell_path_result
    end

    # view files
    actions = result["params"][:options]["actions"].split(",")
    view_files_result = result["view_result"]["files_content"]
    actions.zip(view_files_result).each do |action, view_file_result|
      assert_equal view_file(action), view_file_result
    end

    # view paths
    view_paths.zip(result["view_result"]["files_path"]).each do |view_path, view_path_result|
      assert_equal view_path, view_path_result
    end

  end

end
