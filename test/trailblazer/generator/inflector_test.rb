require 'test_helper'

class Trailblazer::Generator::InflectorTest < Minitest::Test
  def test_camelize_without_path
    assert_equal 'TrailBlazer', Trailblazer::Generator::Inflector.camelize('trail_blazer')
  end

  def test_camelize_with_path
    assert_equal 'TrailBlazer::Operation', Trailblazer::Generator::Inflector.camelize('trail_blazer/operation')
  end

  def test_underscore_without_path
    assert_equal 'trail_blazer', Trailblazer::Generator::Inflector.underscore('TrailBlazer')
  end

  def test_underscore_with_path
    assert_equal 'trail_blazer/operation', Trailblazer::Generator::Inflector.underscore('TrailBlazer::Operation')
  end
end
