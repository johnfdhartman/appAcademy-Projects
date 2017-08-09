require_relative 'board.rb'
require_relative 'cursor.rb'
require 'colorize'
class Display

  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render(player_colour)
    system 'clear'
    #p @board.checkmate?(:red)
    puts "#{player_colour}'s turn".colorize(:color => player_colour)
    @board.grid.each.with_index do |row, idx_1|
      row.each.with_index do |el, idx_2|
        print el.icon.colorize(:color => el.colour,
                               :background => tile_colour(idx_1, idx_2))
      end
      puts
    end
  end

  def get_move(player_colour)
    #outputs an array with two positions: the piece the player
    #wants to move, and the place they want to move it
    move_choice = []
    @cursor.unselect_tile
    until move_choice.length == 2
      p @board.checkmate?(:red)
      p "move_choice #{move_choice}"
      input = @cursor.get_input
      move_choice << input if input
      render(player_colour)
    end
    p move_choice
    move_choice
  end

  def tile_colour(row, col)
    if @cursor.cursor_pos == [row,col]
      @cursor.selected ? :yellow : :green
    elsif (row + col).even?
      :white
    else
      :black
    end
  end

end
