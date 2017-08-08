require_relative 'piece.rb'
require 'colorize'
require_relative 'display'
class Board

  attr_reader :grid

  def initialize
    @grid = initialize_grid
  end

  def initialize_grid(type = :standard)
    null_piece = NullPiece.instance
    if type == :standard
      grid = Array.new(8) {Array.new(8) {null_piece}}
      #back line
      grid[0] = back_line(:red)
      grid[7] = back_line(:cyan)
      #front line
      grid[1] = Array.new(8) {Pawn.new(:red)}
      grid[6] = Array.new(8) {Pawn.new(:cyan)}
    end
    grid
  end

  def back_line(colour)
    row = [Rook.new(colour),
           Knight.new(colour),
           Bishop.new(colour),
           Queen.new(colour),
           King.new(colour),
           Bishop.new(colour),
           Knight.new(colour),
           Rook.new(colour)]
    row.reverse! if colour == :red
    row
  end

  def [](pos)
    x,y = preprocess
    @grid[x][y]
  end

  # def []=(pos, target)
  #   x,y = pos
  #   @grid[x][y] = target
  # end




end
