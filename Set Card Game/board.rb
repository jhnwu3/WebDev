# frozen_string_literal: true

require_relative 'card'
require_relative 'game'
require 'colorize'

# below are the 4 attributes per card
NUMBERS = [1, 2, 3].freeze
COLORS = %w[red blue green].freeze
SYMBOLS = ['{}', '[]', '<>'].freeze
SHADES = ['#', '|', '+'].freeze

#     # gem install colorize
#     instance variables :
#         @deck
#             cards not drawn yet, initally populated with 81 unique cards.
#
#         @ondisplay
#             12 cards drawn and shown to the player on terminal.
#
#     notable methods :
#         update_board
#             - adds 3 cards to @ondisplay if ondisplay has length < 12,
#               meaning user has completed a set and we need to refill the board
#             - ...and then "draws" the 12 cards onto terminal
#             ** @deck having at least 3 cards is checked in game.rb
#
#         add_cards
#             removes 3 cards from @deck and adds to @ondisplay
#             ** @deck having at least 3 cards is checked in game.rb
#
#         remove_cards(set)
#             - set is a integer array of length 3, each integer is a index to
#               @ondisplay. this is the user's attempt at inputting a set
#             - remove @ondisplay.at[i] for each i in set
#
#         check_cards
#             - checks if a set exists in ondisplay
#             - used to determine if we need to add more cards on board for user to play the game
class Board
  # constructor
  def initialize
    # deck of 81 unique cards
    @deck = []
    # 12 cards on display
    @ondisplay = []

    # initialize deck of 81 unique cards
    NUMBERS.each do |num|
      COLORS.each do |col|
        SYMBOLS.each do |sym|
          SHADES.each do |shade|
            @deck.unshift(Card.new(num, col, sym, shade))
          end
        end
      end
    end
    # shuffle deck
    @deck = @deck.shuffle

    # extract 12 cards from deck to show on board
    while @ondisplay.length < 12
      # remove each card from deck and add to ondisplay
      @ondisplay.unshift(@deck.shift)
    end
  end

  # getter methods
  attr_reader :deck

  attr_reader :ondisplay

  # print 12 cards currently in the board to terminal
  def update_board
    # when board has less than 12 cards, add 3 cards
    add_cards if @ondisplay.length < 12 && @deck.length > 2

    # loop through each card in ondisplay and print to screen
    i = 1
    @ondisplay.each do |c|
      # sort out each symbol, shade, etc. on the string
      string_output = "Card # #{i} : "

      # add symbols to each card output
      (0..(c.num - 1)).each do |_n|
        string_output = "#{string_output}#{c.sym[0]}#{c.shade}#{c.sym[1]} "
      end

      # add respective colors to each card
      case c.col
      when 'red'
        puts string_output.red
      when 'blue'
        puts string_output.blue
      when 'green'
        puts string_output.green
      end

      i += 1
    end
  end

  # add 3 cards to deck (after user completes a set)
  def add_cards
    # add three cards to ondisplay from deck
    @ondisplay.unshift(@deck.shift)
    @ondisplay.unshift(@deck.shift)
    @ondisplay.unshift(@deck.shift)
  end

  # argument set here is array of 3 index values on ondisplay that user completed as a set
  def remove_cards(set)
    # remove cards on display that were completed as sets
    # do it in decreasing index order to avoid error (e.g., we remove 1 first and try to remove 8, 8 will be now 9)
    set.sort!.reverse!.each { |i| @ondisplay.delete_at(i.to_i - 1) }
  end

  # check if cards on deck have a set. If set is detected, it returns true immediately else returns false.
  def check_cards
    board = @ondisplay
    checker = CardChecker.new
    (0...board.length).each do |one|
      (0...board.length).each do |two|
        (0...board.length).each do |three|
          if (board[one] != board[two]) && (board[two] != board[three]) && checker.set?(board[one],
                                                                                        board[two], board[three])
            return true
          end
        end
      end
    end
    false
  end
end
