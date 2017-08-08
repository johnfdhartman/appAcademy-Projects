require_relative 'board.rb'
require 'singleton'

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
end

class NullPiece < Piece
  include Singleton

  def initialize
    @colour = nil
    @icon = '  '
  end

end

class Bishop < Piece
  # include SlidingPiece

  def initialize(colour)
    super
  end

end

class Rook < Piece
  # include SlidingPiece

  def initialize(colour)
    super
  end

end

class Queen < Piece
  # include SlidingPiece

  def initialize(colour)
    super
  end

end

class Knight < Piece
  # include SteppingPiece

  def initialize(colour)
    super
  end

end

class King < Piece
  # include SteppingPiece

  def initialize(colour)
    super
  end

end

class Pawn < Piece

  def initialize(colour)
    super
  end

end

module SlidingPiece
  def moves

  end

  def move_dirs

  end
end

module SteppingPiece
  def moves

  end

  def move_dirs

  end

end
