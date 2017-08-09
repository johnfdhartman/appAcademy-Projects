module SlidingPiece
  def valid_moves(grid, pos)
    valids = []
    @move_dirs.each do |dir|
      valids += valid_moves_in_dir(grid,pos,dir)
    end
    valids
  end

  def valid_moves_in_dir(grid, pos, dir)
    valids = []
    stopped, iter = false, 1
    until stopped == true || iter == 7
      move = [pos[0] + (dir[0] * iter), pos[1] + (dir[1] * iter) ]
      case slide_stopper?(grid, move)
      when :stop_before
        stopped = true
      when :stop_at
        valids << move
        stopped = true
      when false
        valids << move
      end
      iter += 1
    end
    valids
  end

  def slide_stopper?(grid,pos)
    if !inside_bounds?(pos) ||
          grid[pos[0]][pos[1]].colour == @colour
      :stop_before
    elsif grid[pos[0]][pos[1]].colour == nil
      false
    else
      :stop_at
    end
  end
end
