class Tile
  attr_reader :given, :value
  def initialize(num)
    @given = (num != 0)
    @value = num
  end

  def update(num)
    if @given
      puts "This is a fixed tile!"
    else
      @value = num
    end
  end

  def to_s
    @value == 0 ? "*" : @value.to_s
  end

end
