require_relative 'minesweeper'
require 'byebug'

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
      until won?
      input = prompt # get r/f & position !!(validate input)
      toggle_flag(input[1]) if input[0] == "f" # if flag, toggle display between "F" & "-"
      return "Game Over!" if input[0] == "r" && bomb?(input[1])
      check(input[1])
    end

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

  def check(pos)
    # debugger
    queue = [pos]
    seen_children = []
    until queue.empty?
      current_children = children(queue.first) # create an array of children positions & remove invalid positions
      x, y = queue.first
      self.board.grid[x][y].display = (current_children.count { |child| bomb?(child) }).to_s
      if board.grid[x][y].display == "0"
        seen_children << queue.shift
        current_children.each do |child|
          queue << child unless seen_children.include?(child) || queue.include?(child)
        end
      else
        queue.shift
      end
      board.display
    end
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
