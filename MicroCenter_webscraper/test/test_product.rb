$LOAD_PATH << '.'

require_relative '../scraper.rb'
require 'minitest/autorun'

class TestProduct < MiniTest::Test
  def setup
    @product = Product.new('awesomelaptop', '999.99', 'asus', 'www.link')
  end

  # test all attributes of the Product
  def test_name
    assert_equal 'awesomelaptop', @product.name
  end

  def test_price
    assert_equal 999.99, @product.price
  end

  def test_brand
    assert_equal 'asus', @product.brand
  end

  def test_link
    assert_equal 'www.link', @product.link
  end
end
