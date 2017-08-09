require_relative "board"
require_relative "display"
require_relative "player"
require 'byebug'
class Game

  def initialize()
    @board = Board.new
    @display = Display.new(@board)
    @game_over = false
    @player_1 = Player.new(:cyan)
    @player_2 = Player.new(:red)
    @current_player = @player_1
  end

  def run
    until @game_over
      @current_player.get_move(@board)
      # p "#{@current_player.colour}'s usable_pieces:
      #   #{@board.checkmate?(@current_player.colour)}"
      if @board.checkmate?(@current_player.colour)
        @game_over = true
      else
        switch_player
      end
    end
    p "#{@current_player.colour} wins! hooray"

  end

  def switch_player
    if @current_player == @player_1
      @current_player = @player_2
    else
      @current_player = @player_1
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.run
end
