require_relative 'minesweeper'
require 'byebug'

class Game

  # BOARD_SIZE = 9

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
    board.display
    until won?
      input = prompt #!!(validate input)
      if input[0] == "f"
        self.board[input[1]].toggle_flag
        board.display
        next
      end
      return "Game Over!" if input[0] == "r" && bomb?(input[1])
      check(input[1])
    end
    puts "Congratulations!"
  end

  def won?
    count = self.board.grid.flatten.count do |obj|
      ("0".."8").include?(obj.display)
    end

    count == (board.board_size ** 2) - board.bomb_number
  end

  def prompt
    valid = false
    until valid
      puts "Please enter either 'r' for (R)eveal or 'f' for (F)lag."
      action = gets.chomp
      valid = action_valid?(action)
    end

    valid = false
    until valid
      puts "Please enter a position"
      pos = gets.chomp.split(",").map { |el| el.to_i }
      valid = pos_valid?(pos)
    end

    [action, pos]
  end

  def action_valid?(action)
    action == "r" || action == "f"
  end

  def pos_valid?(pos)
    pos.all? {|el| el.between?(0,8)} &&
      pos.length == 2 &&
      (board[pos].display == "-" || board[pos].display == "F")
  end

  def bomb?(pos)
    board[pos].bomb
  end

  def check(pos)
    # debugger
    queue = [pos]
    seen_neighbors = []
    until queue.empty?
      current_neighbors = neighbors(queue.first) # create an array of neighbors positions & remove invalid positions
      self.board[queue.first].display = (current_neighbors.count { |neighbor| bomb?(neighbor) }).to_s
      if board[queue.first].display == "0"
        seen_neighbors << queue.shift
        current_neighbors.each do |neighbor|
          queue << neighbor unless seen_neighbors.include?(neighbor) || queue.include?(neighbor)
        end
      else
        queue.shift
      end
    end
    board.display
  end

  def neighbors(pos)
    neighbors = []
    x,y = pos
    SURROUNDING_DELTA.each do |delta|
      neighbor_pos = [(delta[0] + x) , (delta[1] + y)]
      neighbors << neighbor_pos if is_valid?(neighbor_pos)
    end
    neighbors
  end

  def is_valid?(pos)
    pos.all? { |el| el.between?(0,8)}
  end

end
