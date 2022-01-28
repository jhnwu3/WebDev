# frozen_string_literal: true

require_relative 'board'
require_relative 'card'

#   HintGenerator object is used in game.rb to generate hint for the player if the user is stuck.
class HintGenerator
  # returns tuple pair of digits that correspond to each card in a set
  # take OnDisplay as input then output the s
  def give_hint(board)
    checker = CardChecker.new
    (0...board.length).each do |one|
      (0...board.length).each do |two|
        (0...board.length).each do |three|
          # if the cards are not the same and they are a set
          a = board[one]
          b = board[two]
          c = board[three]
          next unless (a != b) && (b != c) && checker.set?(a, b, c)

          # give the hint and return
          puts "Please check the cards at index #{one + 1}, ?, #{three + 1}."
          return 0
        end
      end
    end
    # otherwise, print error
    puts 'Error: No set exists on the board.'
  end
end
