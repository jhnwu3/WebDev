# frozen_string_literal: true

$LOAD_PATH << '.'

require 'minitest/autorun'
require '../card'

class TestCard < Minitest::Test
  def setup
    @card = Card.new(1, 'red', '{}', '#')
  end

  # Testing all the attributes of the card class
  def test_has_number
    assert_respond_to @card, :num
  end

  def test_remembers_number
    assert_equal 1, @card.num
  end

  def test_has_sym
    assert_respond_to @card, :sym
  end

  def test_remembers_sym
    assert_equal '{}', @card.sym
  end

  def test_has_color
    assert_respond_to @card, :col
  end

  def test_remembers_color
    assert_equal 'red', @card.col
  end

  def test_has_shade
    assert_respond_to @card, :shade
  end

  def test_remembers_shade
    assert_equal '#', @card.shade
  end
end

class TestCardChecker < Minitest::Test
  def setup
    @card1 = Card.new(1, 'red', '{}', '#')
    @card2 = Card.new(1, 'green', '[]', '+')
    @card3 = Card.new(1, 'blue', '<>', '|')
    @card4 = Card.new(2, 'red', '<>', '|')

    @checking = CardChecker.new
  end

  # check isSet Functionality if test is true
  def test_isset_true
    expect = @checking.set?(@card1, @card2, @card3)

    assert_equal expect, true
  end

  # check isSet functionality if test is false
  def test_is_set_false
    expect = @checking.set?(@card1, @card2, @card4)

    assert_equal expect, false
  end

  # test check num
  def test_check_num_true
    @carda = Card.new(1, 'red', '{}', '#')
    @cardb = Card.new(1, 'green', '[]', '+')
    @cardc = Card.new(1, 'blue', '<>', '|')

    expect = @checking.check_num(@carda, @cardb, @cardc)

    assert_equal expect, true
  end

  def test_check_num_false
    @carda = Card.new(1, 'red', '{}', '#')
    @cardb = Card.new(2, 'green', '[]', '+')
    @cardc = Card.new(1, 'blue', '<>', '|')

    expect = @checking.check_num(@carda, @cardb, @cardc)

    assert_equal expect, false
  end

  # test check sym
  def test_check_sym_true
    @carda = Card.new(1, 'red', '{}', '#')
    @cardb = Card.new(1, 'green', '{}', '+')
    @cardc = Card.new(1, 'blue', '{}', '#')

    expect = @checking.check_sym(@carda, @cardb, @cardc)

    assert_equal expect, true
  end

  def test_check_sym_false
    @carda = Card.new(1, 'red', '{}', '#')
    @cardb = Card.new(2, 'green', '{}', '+')
    @cardc = Card.new(1, 'blue', '<>', '+')

    expect = @checking.check_sym(@carda, @cardb, @cardc)

    assert_equal expect, false
  end

  # test check color
  def test_check_color_true
    @carda = Card.new(1, 'red', '{}', '#')
    @cardb = Card.new(2, 'red', '[]', '+')
    @cardc = Card.new(1, 'red', '{}', '#')

    expect = @checking.check_col(@carda, @cardb, @cardc)

    assert_equal expect, true
  end

  def test_check_color_false
    @carda = Card.new(1, 'red', '{}', '#')
    @cardb = Card.new(2, 'green', '{}', '+')
    @cardc = Card.new(1, 'green', '<>', '+')

    expect = @checking.check_col(@carda, @cardb, @cardc)

    assert_equal expect, false
  end

  # test check shade
  def test_check_shade_true
    @carda = Card.new(1, 'red', '{}', '#')
    @cardb = Card.new(2, 'red', '[]', '#')
    @cardc = Card.new(1, 'red', '{}', '#')

    expect = @checking.check_shade(@carda, @cardb, @cardc)

    assert_equal expect, true
  end

  def test_check_shade_false
    @carda = Card.new(1, 'red', '{}', '#')
    @cardb = Card.new(2, 'green', '{}', '+')
    @cardc = Card.new(1, 'blue', '<>', '#')

    expect = @checking.check_shade(@carda, @cardb, @cardc)

    assert_equal expect, false
  end
end
