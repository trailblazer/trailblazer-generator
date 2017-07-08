require 'test_helper'


ClassName = Struct.new(:name)

class ClassName::Test < Trailblazer::Operation
  step Trailblazer::Generator::Macro::ValidateClassName()
end

class Trailblazer::Generator::ClassNameTest < Minitest::Test

  def test_invalid_name
    result = ClassName::Test.(name: "report")
    assert_equal true, result.failure?
    assert_equal "You provided an invalid class name. Trailblazer or TrailBlazer is expected", result["failure_message"]
    assert_equal 1, result["error_code"]
  end

  def test_invalid_name_only_numbers
    result = ClassName::Test.(name: "124")
    assert_equal true, result.failure?
    assert_equal "You provided an invalid class name. Trailblazer or TrailBlazer is expected", result["failure_message"]
    assert_equal 1, result["error_code"]
  end

  def test_invalid_name_with_numbers
    result = ClassName::Test.(name: "report124")
    assert_equal true, result.failure?
    assert_equal "You provided an invalid class name. Trailblazer or TrailBlazer is expected", result["failure_message"]
    assert_equal 1, result["error_code"]
  end

  def test_invalid_name_with_column
    result = ClassName::Test.(name: "Report::Create")
    assert_equal true, result.failure?
    assert_equal "You provided an invalid class name. Trailblazer or TrailBlazer is expected", result["failure_message"]
    assert_equal 1, result["error_code"]
  end

  def test_valid_name
    result = ClassName::Test.(name: "Report")
    assert_equal true, result.success?
    assert_equal "Report", result["params"][:name]
  end

  def test_valid_name_UpperCamelCase
    result = ClassName::Test.(name: "RePort")
    assert_equal true, result.success?
    assert_equal "RePort", result["params"][:name]
  end
end
