require_relative 'tile'

class Board
  attr_reader :grid
  def initialize(file = "./sudoku_boards/sudoku1.txt")
    @grid = load_board(file)
  end

  def load_board(file)
    grid = []
    File.open(file).each do |line|
      tile_row = line.chomp.chars.map{|n| Tile.new(n.to_i)}
      p tile_row
      grid << tile_row
    end
    grid
  end

  def render
    puts "     a  b  c  d  e  f  g  h  i"
    puts "   ---------------------------"
    @grid.each.with_index do |row, idx|
      print "#{(idx+97).chr} ||"
      row.each {|tile| print " #{tile.to_s} "}
      print "\n"
    end
    nil
  end

  def coords_to_pos(coords)
    coords.map {|chr| chr.ord-97}
  end

  def update_grid(position, num)
    row,col = position
    @grid[row][col].update(num)
  end

  def section_complete?(sec_array)
    vals = sec_array.map {|tile| tile.value}.sort
    vals == [1,2,3,4,5,6,7,8,9]
  end
end
