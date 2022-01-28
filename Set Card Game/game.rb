
# frozen_string_literal: true

require_relative 'board'
require_relative './player'
require_relative './hint_generator'
require_relative './card'
require 'timeout'

# buzzer system for two player mode
PLAYER_ONE = 'q'
PLAYER_TWO = 'p'
# time limit for single player mode
TIME_LIMIT = 120
# time limit for two player mode - time limit for the buzzed in player
BUZZER_LIMIT = 5

#     Game object is used in main.rb to show menus and start games
#
#     instance variables :
#         @player_scores
#             array of Player objects, length of 5.
#             this array stores top 5 players with highest scores in order.
#
#         @game_board
#             Board object
#
#     methods :
#         show_prompts
#             helper method for printing a
#             set of common prompts with 1-4 input options
#
#         show_main_menu
#             prints welcome message and then calls show_prompts
#
#         show_statistics
#             prints @player_scores (the top 5 players) with name : score
#
#         start_game(num_players)
#             num_players is either "1" or "2" as user inputs in game.rb game loop.
#             "1" is single player, "2" is two players.
#
#             two players mode uses buzzer system where each player inputs buzzer charcter to earn chance
#             to input a set. rule is the player must have the set in mind before pushing the buzzer.
#
#             uses these methods:
#                 game_sesh(player) - starts up a single player game round
#                 multi_game_sesh(player1, player2) - starts up a two player competitive game
#                 add_score(player) - adds player object to @player_scores
#
#         print_get_ready(name)
#             prints get ready, 3, 2, 1 prompts
#
#         game_sesh(player)
#             starts game loop, stores score to player.score
#             returns the modified player object
#             single player game mode is timed by TIME_LIMIT seconds defined in var.rb
#
#         multi_game_sesh
#             starts new game for two players.
#             uses buzzer system "q" for player1, "p" for player2 to determine who gets the right to input a set.
#
#         add_score(player)
#             adds player to @player_scores if it ranks in top 5
#
#         quit_game
#             prints good bye message
class Game
  # Constructor
  def initialize
    # array of 5 player objects - initiazlied with place holder Player objects
    @player_scores = [nil, nil, nil, nil, nil]
    # game board
    @game_board = Board.new
  end

  #getter method 
  def player_scores 
    @player_scores
  end 

  # prints common prompts to the screen
  def show_prompts
    puts 'Menu Options:'
    puts '1: Start Single Player/Coop Mode'
    puts '2: Start Two Player Competitive Mode'
    puts '3: Start Single Player Timed Mode'
    puts '4: Show Scoreboard'
    puts '5: Quit Game'
    puts 'Please enter one of the options :)'
  end

  # show the starting menu and navigation options
  def show_main_menu
    # print welcome message and navigation options
    puts 'Hello, welcome to Game of Set!'
    # print prompts
    show_prompts
  end

  # show statistics function
  def show_statistics
    # print prompt
    puts '-------------------------------'
    puts 'Below are top 5 scores so far in this game session:'
    # print player name : player score in decreasing order from top to bottom
    @player_scores.each do |s|
      puts "#{s.name} : #{s.score}" unless s.nil?
    end
    # print no scores in record message if first object in player_scores is nil
    puts '*No scores in record yet*' if @player_scores[0].nil?
    puts '-------------------------------'
  end

  # game method - starts the game either with 1 player or 2 player.
  def start_game(num_players)
    # #initialize new board object (with deck and board arrays)
    # @game_board = Board.new
    puts '-------------------------------'
    # single player
    case num_players
    when '1'
      # initalize new player & set user name
      puts 'Enter your name:'
      player1 = Player.new
      player1.name = gets.chomp
      puts '-------------------------------'
      # play game, store player score returned by game_sesh
      print_get_ready(player1.name)
      player1 = game_sesh(player1)

      # print score
      puts "You scored : #{player1.score} points!"

      # add player to player_scores
      add_score(player1)

    # two players
    when '2'
      # initialize new players & set player names
      puts "Enter player 1's name:"
      player1 = Player.new
      player1.name = gets.chomp
      puts '-------------------------------'
      puts "Enter player 2's name:"
      player2 = Player.new
      player2.name = gets.chomp
      puts '-------------------------------'

      # play game for two players
      multi_game_sesh(player1, player2)
    when '3'
      # initalize new player & set user name
      puts 'Enter your name:'
      player1 = Player.new
      player1.name = gets.chomp
      puts '-------------------------------'
      # play game, store player score returned by game_sesh
      puts "You will have #{TIME_LIMIT} seconds on the clock."
      print_get_ready(player1.name)
      player1 = timed_game_sesh(player1)

      # print score
      puts "You scored : #{player1.score} points!"

      # add player to player_scores
      add_score(player1)
    end
    puts '-------------------------------'
  end

  # prints get ready, 3, 2, 1, prompts
  def print_get_ready(name)
    puts "#{name}, get ready! "
    sleep 1 # sleeps 1 second
    print ' 3...'
    sleep 1 # sleeps 1 second
    print ' 2...'
    sleep 1 # sleeps 1 second
    puts ' 1...'
    sleep 1 # sleeps 1 second
    puts 'Game Start!!'
  end

  # adds player to player_scores if it ranks in top 5
  def add_score(player)
    # while loop stop condition
    continue = true
    # index used in while loop
    i = 0

    # loop through each player in @player_scores until player added or end of @player_scores reached
    while continue && (i <= @player_scores.length)
      # if empty spot found, add player to the empty spot
      if @player_scores[i].nil?
        @player_scores[i] = player
        # exit loop
        continue = false
      # if player.score is higher than @player_scores.at[i].score
      elsif @player_scores[i].score < player.score
        # if player names are the same, just update the score
        if @player_scores[i].name == player.name
          @player_scores[i].score = player.score
          # otherwise, insert player at ith spot
        else
          @player_scores.insert(i, player)
          # ...and remove the 6th score since it is now not in top 5
          @player_scores.pop
        end
        # exit loop
        continue = false
      end
      # increase index
      i += 1
    end
  end

  # one round of game session
  def game_sesh(player)
    # reset board (deck and ondisplay)
    @game_board = Board.new
    turns = 5
    # loops until time runs out or deck runs out of cards
    while @game_board.deck.length.positive? && turns.positive?
      # dislay board
      @game_board.update_board
      # add 3 more cards if no sets found
      while @game_board.check_cards == false && @game_board.deck.length > 2
        puts 'No cards displayed can form a set, adding 3 more cards...'
        @game_board.add_cards
        @game_board.update_board
      end
      # display current score and time left

      puts '-------------------------------'
      puts "Turns left : #{turns}"
      puts "Current score : #{player.score}"
      # print number of cards remaining in deck
      puts "Cards remaining in deck : #{@game_board.deck.length}"
      puts '-------------------------------'

      # give hint if user wants it
      puts "Enter ! ONLY if you're absolutely stuck! Otherwise, just press enter:"
      hinting = HintGenerator.new
      hinting.give_hint(@game_board.ondisplay) if gets.chomp == '!'
      puts '-------------------------------'

      # Error check and prompt user to enter a set, make sure it is a valid string and a valid integer value
      # set will be array of length 3, with each element being card #
      begin
        puts "Enter a set by entering 3 valid card #'s separated by a space (e.g.:1 11 8):"
        set = gets.chomp.split
        temp_len = @game_board.ondisplay.length
        while (Integer(set[0]) > temp_len) || (Integer(set[1]) > temp_len) || (Integer(set[2]) > temp_len)
          puts 'Please enter a valid set of card numbers!'
          set = gets.chomp.split
        end
      rescue StandardError
        retry # force user to retry if inputs a non-number
      end

      # if user input a set, remove those cards, increase score by 1
      checking = CardChecker.new
      if checking.set? @game_board.ondisplay[set[0].to_i - 1], # offset by since index starts at 0
                       @game_board.ondisplay[set[1].to_i - 1],
                       @game_board.ondisplay[set[2].to_i - 1]

        puts 'You input a correct set!'
        player.score += 1
        puts '-------------------------------'
        # remove the three cards from the board to be replaced by cards from deck
        @game_board.remove_cards(set)
      # if user input a wrong set, decrease score by 1
      else
        puts 'Sorry, that is not a set :('
        player.score -= 1
        puts '-------------------------------'
      end
      turns -= 1
    end
    player
  end

  # one round of timed game session
  def timed_game_sesh(player)
    # reset board (deck and ondisplay)
    @game_board = Board.new

    # time limit clock
    begin
      Timeout.timeout(TIME_LIMIT) do
        # loops until time runs out or deck runs out of cards
        while @game_board.deck.length.positive?
          # dislay board
          @game_board.update_board

          # add 3 more cards if no sets found
          while @game_board.check_cards == false && @game_board.deck.length > 2
            puts 'No cards displayed can form a set, adding 3 more cards...'
            @game_board.add_cards
            @game_board.update_board
          end
          # display current score and time left
          puts '-------------------------------'
          puts "Current score : #{player.score}"
          # print number of cards remaining in deck
          puts "Cards remaining in deck : #{@game_board.deck.length}"
          puts '-------------------------------'

          # give hint if user wants it
          puts "Enter ! ONLY if you're absolutely stuck! Otherwise, just press enter:"
          hinting = HintGenerator.new
          hinting.give_hint(@game_board.ondisplay) if gets.chomp == '!'
          puts '-------------------------------'

          # Error check and prompt user to enter a set, make sure it is a valid string and a valid integer value
          # set will be array of length 3, with each element being card #
          begin
            puts "Enter a set by entering 3 valid card #'s separated by a space (e.g.:1 11 8):"
            set = gets.chomp.split
            temp_len = @game_board.ondisplay.length
            while Integer(set[0]) > temp_len || Integer(set[1]) > temp_len || Integer(set[2]) > temp_len
              puts 'Please enter a valid set of card numbers!'
              set = gets.chomp.split
            end
          rescue StandardError
            retry # force user to retry if inputs a non-number
          end

          # if user input a set, remove those cards, increase score by 1
          checking = CardChecker.new
          if checking.set? @game_board.ondisplay[set[0].to_i - 1], # offset by since index starts at 0
                           @game_board.ondisplay[set[1].to_i - 1],
                           @game_board.ondisplay[set[2].to_i - 1]

            puts 'You input a correct set!'
            player.score += 1
            puts '-------------------------------'
            # remove the three cards from the board to be replaced by cards from deck
            @game_board.remove_cards(set)
          # if user input a wrong set, decrease score by 1
          else
            puts 'Sorry, that is not a set :('
            player.score -= 1
            puts '-------------------------------'
          end
        end
      end
    rescue Timeout::Error
      # print time over message
      puts '-------------------------------'
      puts 'Time Over!'
    end
    player
  end

  # one round of multi game session
  def multi_game_sesh(player1, player2)
    # turn limit of 10 for both players
    rem_turn = 10

    # reset board (deck and ondisplay)
    @game_board = Board.new

    # print game start prompt
    print_get_ready('Players')

    # loosp until time runs out or deck runs out of cards
    while rem_turn >= 0 && @game_board.deck.length.positive?
      # dislay board
      @game_board.update_board

      # add 3 more cards if no sets found
      while @game_board.check_cards == false && @game_board.deck.length > 2
        puts 'No cards displayed can form a set, adding 3 more cards...'
        @game_board.add_cards
        @game_board.update_board
      end
      # display current score and time lefts
      puts '-------------------------------'
      puts "Turns : #{rem_turn} turns left"
      puts "#{player1.name}’s score : #{player1.score}"
      puts "#{player2.name}’s score : #{player2.score}"

      # print who is currently winning
      puts "#{player1.name} is winning!!" if player1.score > player2.score
      puts "#{player2.name} is winning!!" if player2.score > player1.score
      puts "Game is tied, it's anyone's game now!" if player1.score == player2.score

      # print number of cards remaining in deck
      puts "Cards remaining in deck : #{@game_board.deck.length}"
      puts '-------------------------------'

      # give hint if user wants it
      puts "Enter ! ONLY if you're absolutely stuck! Otherwise, just press enter:"
      hinting = HintGenerator.new
      hinting.give_hint(@game_board.ondisplay) if gets.chomp == '!'
      puts '-------------------------------'

      # use buzzer to see who deserves to answer first
      # loops until valid input is selected.
      turn_indicator = ''
      while turn_indicator != PLAYER_ONE && turn_indicator != PLAYER_TWO
        puts 'Please enter the respective buzzer to get the right to answer!'
        puts "You have #{BUZZER_LIMIT} seconds to input a set once the buzzer is entered!"
        puts 'Player 1’s buzzer : q'
        puts 'Player 2’s buzzer : p'
        turn_indicator = gets.chomp
      end

      # indicate who got the chance to answer
      if turn_indicator == PLAYER_ONE
        puts 'Player 1, you pressed the buzzer first!'
      else
        puts 'Player 2, you pressed the buzzer first!'
      end
      puts '-------------------------------'

      # prompt that player has BUZZER_LIMIT seconds left to input a set
      puts "You have #{BUZZER_LIMIT} seconds left to input a set."

      # start timer with BUZZER_LIMIT
      begin Timeout.timeout(BUZZER_LIMIT) do
        # Error check and prompt user to enter a set, make sure it is a valid string and a valid integer value
        # set will be array of length 3, with each element being card #
        begin
          puts "Enter a set by entering 3 valid card #'s separated by a space (e.g.:1 11 8):"
          set = gets.chomp.split
          temp_len = @game_board.ondisplay.length
          while Integer(set[0]) > temp_len || Integer(set[1]) > temp_len || Integer(set[2]) > temp_len
            puts 'Please enter a valid set of card numbers!'
            set = gets.chomp.split
          end
        rescue StandardError
          retry # force user to retry if inputs a non-number
        end

        # reduce number of remaining turn by 1
        rem_turn -= 1

        # if user input a set, remove those cards, increase score by 1
        checking = CardChecker.new
        if checking.set? @game_board.ondisplay[set[0].to_i - 1], # offset by since index starts at 0
                         @game_board.ondisplay[set[1].to_i - 1],
                         @game_board.ondisplay[set[2].to_i - 1]
          if turn_indicator == PLAYER_ONE
            puts "#{player1.name} input a correct set!"
            puts "Nice work #{player1.name}!"
            player1.score += 1
          else
            puts "#{player2.name} input a correct set!"
            puts "Nice work #{player2.name}!"
            player2.score += 1
          end
          puts '-------------------------------'
          # remove the three cards from the board to be replaced by cards from deck
          @game_board.remove_cards(set)
        # if user input a wrong set, decrease score by 1
        else
          puts 'Sorry, that is not a set :('
          if turn_indicator == PLAYER_ONE
            puts "That’s unfortunate #{player1.name}!"
            player1.score -= 1
          else
            puts "That’s unfortunate #{player2.name}!"
            player2.score -= 1
          end
          puts '-------------------------------'
        end
      end
      rescue Timeout::Error
        # print time over message
        puts '-------------------------------'
        if turn_indicator == PLAYER_ONE
          puts "#{player1.name} ran out of time!"
          puts "-2 points penalty for #{player1.name} applied!"
          player1.score -= 2
        else
          puts "#{player2.name} ran out of time!"
          puts "-2 points penalty for #{player2.name} applied!"
          player2.score -= 2
        end
        puts '-------------------------------'
      end
    end
    # print time over message
    puts 'Game Over!'
    puts '-------------------------------'

    # print scores
    puts "#{player1.name}'s score : #{player1.score}"
    puts "#{player2.name}'s score : #{player2.score}"

    # print who the winner is
    if player1.score > player2.score
      puts "#{player1.name} DESTROYED #{player2.name}!!"
    else
      puts "#{player2.name} DESTROYED #{player1.name}!!"
    end
    puts '-------------------------------'
  end

  # Quit Game - quits game by printing good bye screen
  def quit_game
    puts '-------------------------------'
    # print good bye message
    puts 'Thanks for playing the game,'
    puts 'Good bye :D'
  end
end

