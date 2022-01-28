# frozen_string_literal: true

$LOAD_PATH << '.'

require 'minitest/autorun'

require_relative '../player.rb'

class TestPlayer < Minitest::Test
  def setup
    @player = Player.new
  end

  # testing player objects constructor
  def test_constructor
    @player = Player.new
    assert_equal @player.name, ''
    assert_equal @player.score, 0
  end

  # testing player objects assignments
  def test_constructor_assignment
    @player.name = 'bob'
    @player.score = 2

    assert_equal @player.name, 'bob'
    assert_equal @player.score, 2
  end
end
