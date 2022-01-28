# frozen_string_literal: true

$LOAD_PATH << '.'

require 'minitest/autorun'

require '../board'
require '../card'

class TestBoard < Minitest::Test
  def setup
    @game_board = Board.new
  end

  # testing if the size of the deck is correct
  def test_board_size
    @game_board = Board.new
    expect = @game_board.ondisplay.length

    assert_equal expect, 12
  end

  def test_deck_size
    @game_board = Board.new
    expect = @game_board.deck.length

    assert_equal expect, 69
  end

  def test_check_add_cards
    @game_board.add_cards

    expected_deck = @game_board.deck.length
    expected_display = @game_board.ondisplay.length

    assert_equal expected_deck, 66
    assert_equal expected_display, 15
  end
end
