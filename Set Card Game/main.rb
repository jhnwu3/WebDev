# frozen_string_literal: true

require_relative 'game'
# run this file to start game!

# user input constants
SINGLE = '1'
DOUBLE = '2'
SINGLE_TIMED = '3'
STATS = '4'
QUIT = '5'

# new game object
new_game = Game.new
# initial empty input
input = ''

# main game loop, repeat until input was "4" indicating exit game
while input != QUIT
  # show main menu
  new_game.show_main_menu
  # get user input from menu options
  input = gets.chomp

  # start game, show stats, or quit game depending on user input
  case input
  when SINGLE
    new_game.start_game SINGLE
  when DOUBLE
    new_game.start_game DOUBLE
  when SINGLE_TIMED
    new_game.start_game SINGLE_TIMED
  when STATS
    new_game.show_statistics
  when QUIT
    new_game.quit_game
  else
    puts 'Invalid input, please try again.'
  end

end
