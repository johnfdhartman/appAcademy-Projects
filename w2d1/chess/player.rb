class Player
  attr_reader :colour
  
  def initialize(colour)
    @colour = colour
  end

  def get_move(board)
    board.move_piece(@colour)
  end

end
