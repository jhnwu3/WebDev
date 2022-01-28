$LOAD_PATH << '.'

require 'minitest/autorun'


require_relative '../game.rb'
require_relative '../player.rb'

class TestGame < Minitest::Test

    def setup
       @game = Game.new
       @player =Player.new 
    end
    #player attributes 
    def test_get_name
        @player.name ="Sarah"

        expect = @player.name
        actual = "Sarah"
        assert_equal expect, actual
    end

    def test_get_score
        @player.score=0
        expect = @player.score
        actual = 0
        assert_equal expect, actual
    end

    #testing method add_score
    def test_add_score
        

        @game.add_score(@player)

        expectedArray= (@game.player_scores)
        expected = expectedArray.include? @player
        actual = TRUE

        assert_equal expected, actual 
        
    end 

    
end