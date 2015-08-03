class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(9) { Array.new(9) {Tile.new} }
    place_bombs
  end


  def board_spaces
    spaces = []
    (0..8).each do |row|
      (0..8).each do |space|
        spaces << [row, space]
      end
    end
    spaces
  end

  def display
    grid.each do |row|
      puts row.join(" ")
    end

    nil
  end

  def place_bombs
    bomb_spaces = board_spaces.sample(10)
    bomb_spaces.each do |space|
      x, y = space
      grid[x][y].bomb = true
    end
  end

end

class Tile

  attr_accessor :bomb, :display

  def initialize
    @bomb = false
    @display = "-"
  end

  def to_s
    display
  end

end
