require_relative 'piece.rb'
require 'colorize'
require_relative 'display'
class Board

  attr_reader :display
  attr_accessor :grid

  def initialize(grid = nil)
    if grid
      @grid = grid
    else
      @grid = initialize_grid
    end
    @display = Display.new(self)
  end

  def initialize_grid(type = :standard)
    null_piece = NullPiece.instance
    if type == :standard
      grid = Array.new(8) {Array.new(8) {null_piece}}
      #back line
      grid[0] = back_line(:red)
      grid[7] = back_line(:cyan)
      #front line
      grid[1] = Array.new(8) {Pawn.new(:red, false)}
      grid[6] = Array.new(8) {Pawn.new(:cyan, true)}
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
    #row.reverse! if colour == :red
    row
  end

  def move_piece(player_colour)
    moved = false
    @display.render(player_colour)
    until moved
      origin, destination = @display.get_move(player_colour)
      piece = self[origin]
      if piece.colour == player_colour &&
                piece.non_checking_moves(self,origin).include?(destination)
        self[origin] = NullPiece.instance
        self[destination] = piece
        moved = true
        piece.has_moved if piece.class == Pawn
      end
    end
    nil
  end

  def checkmate?(colour)
    # [usable_pieces, usable_pieces.length == 0]
    pieces_pos = enemy_pieces(colour)
    pieces_pos.select! do |piece_pos|
      piece, pos = piece_pos
      piece.non_checking_moves(self, pos).length > 0
    end
    pieces_pos.length == 0
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def move_into_check?(origin,destination)
    #returns true if moving a piece would expose the same colour's king
    piece, colour = self[origin], self[origin].colour
    temp_board = Board.copy_board(self)
    temp_board[origin] = NullPiece.instance
    temp_board[destination] = piece
    temp_board.grid.each.with_index do |row, r_idx|
      row.each.with_index do |piece_2, c_idx|
        if piece_2.colour != colour &&
              temp_board.threatens_king?(piece_2, [r_idx, c_idx])
          return true
        end
      end
    end
    false
  end

  protected

  def enemy_pieces(colour)
    pieces = []
    grid.each.with_index do |row, r_idx|
      row.each.with_index do |e_piece, c_idx|
        unless [nil, colour].include?(e_piece.colour)
          pieces << [e_piece, [r_idx, c_idx]]
        end
      end
    end
    pieces
  end

  def []=(pos, target)
    x,y = pos
    @grid[x][y] = target
  end

  def threatens_king?(piece, position)
    #p "piece: #{piece}. position: #{position}"
    colour = piece.colour
    piece.valid_moves(grid,position).any? do |move|
      self[move].class == King and self[move].colour != colour
    end
  end


  def self.copy_board(board)
    new_grid = Array.new(8) {Array.new(8)}
    board.grid.each.with_index do |row, r_idx|
      row.each.with_index do |piece, c_idx|
        if piece.class == NullPiece
          new_grid[r_idx][c_idx] = piece
        else
          new_grid[r_idx][c_idx] = piece.dup
        end
      end
    end
    Board.new(new_grid)
  end


end
