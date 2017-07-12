require 'test_helper'
require 'fakefs/safe'

class Trailblazer::Generator::BuilderCellTest < Minitest::Test
  def test_build_operation
    str_op_create = <<~EOF
      class Blog::Create < Trailblazer::Operation
        class Present < Trailblazer::Operation
          step Model(Blog, :new)
          step Contract::Build( constant: Blog::Contract::Create )
        end

        step Nested( Present )
        step Contract::Validate( key: :blog )
        step Contract::Persist( )
      end
    EOF

    str_op_update = <<~EOF
      class Blog::Update < Trailblazer::Operation
        class Present < Trailblazer::Operation
          step Model(Blog, :find_by)
          step Contract::Build( constant: Blog::Contract::Update )
        end

        step Nested( Present )
        step Contract::Validate( key: :blog )
        step Contract::Persist( )
      end
    EOF

    str_op_index = <<~EOF
      class Blog::Index < Trailblazer::Operation
        step :model!

        def model!(options, *)
          options["model"] = ::Blog.all
        end
      end
    EOF

    str_op_show = <<~EOF
      class Blog::Show < Trailblazer::Operation
        step Model(Blog, :find_by)
      end
    EOF

    str_op_delete = <<~EOF
      class Blog::Delete < Trailblazer::Operation
        step Model(Blog, :find_by)
        step :delete!

        def delete!(options, model:, **)
          model.destroy
        end
      end
    EOF

    Trailblazer::Generator::Builder::Operation.(name: "Blog", options: {"actions" => "create,update,index,show,delete"})

    assert_equal str_op_create, File.read('app/concepts/blog/operation/create.rb')
    assert_equal str_op_update, File.read('app/concepts/blog/operation/update.rb')
    assert_equal str_op_index, File.read('app/concepts/blog/operation/index.rb')
    assert_equal str_op_show, File.read('app/concepts/blog/operation/show.rb')
    assert_equal str_op_delete, File.read('app/concepts/blog/operation/delete.rb')
  end

  def test_build_operation_custom_no_present
    str = <<~EOF
      class BlogPost::Custom < Trailblazer::Operation
        step Contract::Validate()
        step Contract::Persist()
      end
    EOF


    Trailblazer::Generator::Builder::Operation.(name: "BlogPost", options: {present: false, "actions" => "custom"})

    assert_equal str, File.read('app/concepts/blog_post/operation/custom.rb')
  end

  def test_build_operation_custom_with_present
    str = <<~EOF
      class BlogPost::Custom < Trailblazer::Operation
        class Present < Trailblazer::Operation
          step Model( BlogPost, :new )
          step :decorate!
          step Contract::Build( constant: Form::Create )

          def decorate!(options, model:, **)
            options["model"] = Twin::Create.new(model)
          end
        end
        step Nested( Present )
        step Contract::Validate()
        step Contract::Persist()
      end
    EOF


    Trailblazer::Generator::Builder::Operation.(name: "BlogPost", options: {present: true, "actions" => "custom"})

    assert_equal str, File.read('app/concepts/blog_post/operation/custom.rb')
  end
end
