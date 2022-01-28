# frozen_string_literal: true
$LOAD_PATH << '.'

require 'minitest/autorun'
require_relative '../calc'
require_relative '../scraper'
#Testing Calc Class
#  methods:
#    setup - to build a hash with fake product list
#    test methods used to test functionality of methods in calc.rb class"
#
class TestCalc < MiniTest::Test
  
  def setup
      @item1 = Product.new('item', 1, 'lenovo', 'www.jobs.com')
      @item2 = Product.new('item2', 2, 'machintosh', 'www.microboy.com')
      @item3 = Product.new('item3', 3, 'asus', 'www.microboy.com')
      @item4 = Product.new('item4',4, 'asus', 'www.mic.com')
  
      @score = [100, 200, 300, 400]
      @products = [@item1, @item2, @item3, @item4]
  
      @items = Hash[@products.zip @score]
      @calculator =Calc.new
  end

  def test_average_price
    actual = @calculator.average_price(@products)
    assert_equal 2.5, actual
  end

  def test_score_over_price
    actual = @calculator.score_over_price(@score[0], @products[0])
    assert_equal 100, actual
  end

  def test_find_max_price
    actual = @calculator.find_max_price(@products)
    max_expected = @products[3]
    assert_equal max_expected, actual
  end

  def test_find_min_price
    actual = @calculator.find_min_price(@products)
    max_expected = @products[0] 
    assert_equal max_expected, actual
  end

  def test_find_max
    actual = @calculator.find_max(@items)
    max_expected = [@products[0], @score[0]]
    assert_equal max_expected, actual
  end
end
