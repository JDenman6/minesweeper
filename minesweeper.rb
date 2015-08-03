class Board
  attr_reader :grid
  attr_accessor :board_size, :bomb_number

  def initialize(board_size = 9, bomb_number = 10)
    @board_size = board_size
    @bomb_number = bomb_number
    @grid = Array.new(board_size) { Array.new(board_size) {Tile.new} }
    place_bombs(bomb_number)
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
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

  def place_bombs(bomb_number)
    bomb_spaces = board_spaces.sample(bomb_number)
    bomb_spaces.each do |space|
      self[space].bomb = true
    end
  end

end

class Tile

  attr_accessor :bomb, :display, :revealed

  def initialize
    @bomb = false
    @display = "-"
    @revealed = false
  end

  def bomb?
    self.bomb
  end

  def revealed?
    self.revealed
  end

  def to_s
    display
  end

  def toggle_flag
    self.display = (display == "F") ? "-" : "F"
  end

  def reveal
    self.revealed = true
  end
end
