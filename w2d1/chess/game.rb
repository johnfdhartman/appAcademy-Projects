require_relative "board"
class Game

  def initialize

  end

  def run

  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  d = Display.new(b)
  d.get_move
end
