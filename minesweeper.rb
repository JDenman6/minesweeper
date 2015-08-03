class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(9) { Array.new(9) }
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

  def place_bombs
    # bomb_spaces = board_spaces.sample(10)
    # bomb_spaces.each do |space|
    #
    # end
  end

end
