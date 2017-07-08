require 'test_helper'
require 'fakefs/safe'

class Trailblazer::Generator::BuilderCellTest < Minitest::Test
  def test_build_operation_no_present
    str = <<~EOF
      class Blog::Create < Trailblazer::Operation

        step Model( Blog, :# add_action )
        step Contract::Build( constant: Form::Create )
        step Contract::Validate()
        step Contract::Persist()

      end
    EOF


    Trailblazer::Generator::Builder::Operation.(name: "Blog", options: {present: false, action: "create"})

    assert_equal str, File.read('app/concepts/blog/operation/create.rb')
  end

  def test_build_operation_with_present
    str = <<~EOF
      class BlogPost::Create < Trailblazer::Operation

        class Present < Trailblazer::Operation
          step Model( BlogPost, :new )
          step Contract::Build( constant: Form::Create )
        end

        step Nested( Present )
        step Contract::Validate()
        step Contract::Persist()

      end
    EOF


    Trailblazer::Generator::Builder::Operation.(name: "BlogPost", options: {present: true, action: "create"})

    assert_equal str, File.read('app/concepts/blog_post/operation/create.rb')
  end
end
