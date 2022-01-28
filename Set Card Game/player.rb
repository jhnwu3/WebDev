# frozen_string_literal: true

#     player object
#
#     instance variables
#         @name : name of the player
#         @score : score of the player
class Player
  # constructor
  def initialize
    @name = ''
    @score = 0
  end

  # getter methods
  attr_accessor :name
  attr_accessor :score
end
