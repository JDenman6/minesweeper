require_relative 'minesweeper'

class Game

  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    board.display # display board to player
    input = prompt # get r/f & position !!(validate input)
    toggle_flag(input[1]) if input[0] == "f"
    board.display
    # if flag, toggle display between "F" & "-"
    # if reveal
      # check if pos bomb
        # bomb => game over
      # not bomb => check surroundings for bombs & check pos valid?
  end

  def prompt
    puts "Please enter either 'r' for (R)eveal or 'f' for (F)lag."
    action = gets.chomp
    puts "Please enter a position"
    pos = gets.chomp.split(",").map { |el| el.to_i }
    [action, pos]
  end

  def toggle_flag(pos)
    y, x = pos
    board.grid[x][y].display = (board.grid[x][y].display == "F") ? "-" : "F"
  end

end
