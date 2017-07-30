require 'test_helper'
require 'fakefs/safe'

class Trailblazer::Generator::Builder::ContractTest < Minitest::Test
  def test_build_operation_no_properties
    str_contract_new = <<~EOF
      module BlogPost::Contract
        class New < Reform::Form
        end
      end
    EOF

    str_contract_edit = <<~EOF
      module BlogPost::Contract
        class Edit < Reform::Form
        end
      end
    EOF


    Trailblazer::Generator::Builder::Contract.(name: "BlogPost", options: {"actions" => "new,edit", "properties" => []}, command: 'contract')

    assert_equal str_contract_new, File.read('app/concepts/blog_post/contract/new.rb')
    assert_equal str_contract_edit, File.read('app/concepts/blog_post/contract/edit.rb')
  end

  def test_build_operation_with_properties
    str = <<~EOF
      module BlogPost::Contract
        class Edit < Reform::Form
          property :title
          property :subtitle
          property :body
        end
      end
    EOF


    Trailblazer::Generator::Builder::Contract.(name: "BlogPost", options: {"actions" => "edit", "properties" => ["title", "subtitle", "body"]}, command: 'contract')

    assert_equal str, File.read('app/concepts/blog_post/contract/edit.rb')
  end

end
