require_relative 'board.rb'
require_relative 'cursor.rb'
require 'colorize'
class Display

  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    @board.grid.each.with_index do |row, idx_1|
      row.each.with_index do |el, idx_2|
        print el.icon.colorize(:color => el.colour,
                               :background => tile_colour(idx_1, idx_2))
      end
      puts
    end
  end

  def get_move
    moved = false
    @cursor.selected = false
    until moved
      @cursor.get_input
      system 'clear'
      render
    end
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
