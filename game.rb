require_relative 'minesweeper'

class Game

  SURROUNDING_DELTA = [
    [-1,  1],
    [-1,  0],
    [-1, -1],
    [ 1,  0],
    [ 1,  1],
    [ 1, -1],
    [ 0,  1],
    [ 0, -1]
  ]

  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    board.display # display board to player
    input = prompt # get r/f & position !!(validate input)
    toggle_flag(input[1]) if input[0] == "f" # if flag, toggle display between "F" & "-"
    board.display
    return "Game Over!" if input[0] == "r" && bomb?(input[1])
    recursive_check(input[1])

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
    x, y = pos
    board.grid[x][y].display = (board.grid[x][y].display == "F") ? "-" : "F"
  end

  def bomb?(pos)
    x, y = pos
    board.grid[x][y].bomb
  end

  def recursive_check(pos)
    
    # create an array of children positions
    # remove invalid positions
    # add valid positions to queue unless it is already there
    # iterate over queue looking for base condition
    # base condition is that child holds a bomb
    # count how many bombs that child can see
    # update child space to bomb count
  end

  def children(pos)
    children = []
    x,y = pos
    SURROUNDING_DELTA.each do |delta|
      child_pos = [(delta[0] + x) , (delta[1] + y)]
      children << child_pos if is_valid?(child_pos)
    end
    children
  end

  def is_valid?(pos)
    pos.all? { |el| el.between?(0,8)}
  end

end
