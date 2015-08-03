require_relative 'minesweeper'

class Game

  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    board.display # display board to player

    # get r/f & position (validate input)
    # if flag, toggle display between "F" & "-"
    # if reveal
      # check if pos bomb
        # bomb => game over
      # not bomb => check surroundings for bombs & check pos valid?
  end

end
