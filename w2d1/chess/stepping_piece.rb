module SteppingPiece
  def valid_moves(grid, pos)
    moves = @move_offsets.map do |offset|
      [offset[0] + pos[0], offset[1] + pos[1]]
    end
    moves.select! do |move|
      inside_bounds?(move)
    end
    moves.select do |move|
      grid[move[0]][move[1]].colour != @colour
    end
  end
end
