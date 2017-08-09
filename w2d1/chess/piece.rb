require_relative 'board.rb'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require 'singleton'
require 'byebug'

class Piece
  attr_reader :colour, :icon

  def initialize(colour)
    @colour = colour
    @icon = pick_icon(colour, self.class)
  end

  def pick_icon(colour, piece_class)
    piece_icons =
    {:cyan => {Bishop => '♝ ',
                Rook => '♜ ',
                Knight => '♞ ',
                Queen => '♛ ',
                King => '♚ ',
                Pawn => '♟ '},
    :red =>  {Bishop => '♝ ',
                Rook => '♜ ',
                Knight => '♞ ',
                Queen => '♛ ',
                King => '♚ ',
                Pawn => '♟ '}}

    piece_icons[colour][piece_class]
  end

  def inside_bounds?(pos)
    pos.all? {|dim| dim < 8 && dim >=0}
  end

  def valid_moves(grid, pos)
    []
  end

  def non_checking_moves(board, pos)
    valid_moves(board.grid,pos).select do |move|
      !(board.move_into_check?(pos,move))
    end
  end
end

class NullPiece < Piece
  include Singleton

  def initialize
    @colour = nil
    @icon = '  '
  end

end

class Bishop < Piece
  include SlidingPiece

  def initialize(colour)
    @move_dirs = [[1,1],[-1,-1],[1,-1],[-1,1]]
    super
  end

end

class Rook < Piece
  include SlidingPiece

  def initialize(colour)
    @move_dirs = [[1,0],[-1,0],[0,1],[0,-1]]
    super
  end

end

class Queen < Piece
  include SlidingPiece

  def initialize(colour)
    @move_dirs = [[1,0],[-1,0],[0,1],[0,-1],
                  [1,1],[-1,-1],[1,-1],[-1,1]]
    super
  end

end

class Knight < Piece
  include SteppingPiece

  def initialize(colour)
    @move_offsets = [[2,1],[2,-1],[-2, 1],[-2, -1],
                      [1,2],[1,-2],[-1,2],[-1, -2]]
    super
  end

end

class King < Piece
  include SteppingPiece

  def initialize(colour)
    @move_offsets = [[1,0],[-1,0],[0,1],[0,-1],
                  [1,1],[-1,-1],[1,-1],[-1,1]]
    super
  end

end

class Pawn < Piece
  attr_reader :moved, :normal_offsets, :capture_offsets

  def initialize(colour, reverse)

    if reverse
      @capture_offsets = [[-1,-1],[-1,1]]
      @normal_offsets = [[-1,0], [-2,0]]
    else
      @capture_offsets = [[1,1],[1,-1]]
      @normal_offsets = [[1,0], [2,0]]
    end
    @moved = false
    super(colour)
  end

  def valid_moves(grid,pos)
    capture_moves(grid, pos) + normal_moves(grid, pos)
  end

  def capture_moves(grid, pos)
    cap_moves = @capture_offsets.map do |offset|
      [offset[0]+pos[0], offset[1] + pos[1]]
    end
    cap_moves.select! do |move|
      inside_bounds?(move) &&
      ![nil, @colour].include?(grid[move[0]][move[1]].colour)
    end
    cap_moves
  end

  def normal_moves(grid, pos)
    moves = @normal_offsets.map do |offset|
      [offset[0] + pos[0], offset[1] + pos[1]]
    end
    moves.select do |move|
      inside_bounds?(move) &&
      grid[move[0]][move[1]].colour.nil?
    end
    moves.pop if @moved
    moves
  end

  def reverse_offsets(offsets)
    #flips the ways the pawn can move
    #if it's facing the reverse direction
  end

  def has_moved
    @moved = true
  end

end

module SteppingPiece
  def moves

  end

  def move_dirs

  end

end
