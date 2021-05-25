# frozen_string_literal: true

class Array
  def all_empty?
    all? { |ele| ele == ' . ' }
  end

  def all_same?
    all? { |ele| ele == self[0] }
  end
end

# is player
class Player
  attr_reader :name, :tile
  attr_accessor :turn

  def initialize(name, tile)
    @name = name
    @tile = tile
    @turn = false
  end
end

# is game board
class Board
  attr_accessor :grid

  def initialize
    @grid = default_grid
  end

  def make_move(row, col, tile)
    if @grid[row][col] != ' . '
      puts 'Invalid move.'
      return nil
    end
  rescue StandardError
    puts 'Invalid move.'
  else
    @grid[row][col] = tile
  end

  def game_over?
    if winner?
      puts 'Game over.'
      true
    elsif grid.flatten.include?(' . ')
      false
    else
      puts "It's a draw!"
      true
    end
  end

  private

  def default_grid
    Array.new(3) { Array.new(3) { ' . ' } }
  end

  def winner?
    winning_positions.each do |winning_position|
      next if winning_position.all_empty?
      return true if winning_position.all_same?
    end
    false
  end

  def winning_positions
    grid +
      grid.transpose +
      diagonals
  end

  def diagonals
    [
      [grid[0][0], grid[1][1], grid[2][2]],
      [grid[0][2], grid[1][1], grid[2][0]]
    ]
  end
end

# ---------------------------------------------------
def play_game
  player2 = Player.new('Player 2', 'O')
  player1 = Player.new('Player 1', 'X')
  new_board = Board.new
  game_over = false
  player1.turn = true

  until game_over
    if player1.turn == true
      player_moves(player1, new_board)
      player2.turn = turn1?(player1, player2)
    elsif player2.turn == true
      player_moves(player2, new_board)
      player1.turn = turn2?(player1, player2)
    end
    game_over = new_board.game_over?
  end
end

def player_moves(current_player, current_board)
  puts current_player.name.to_s
  puts 'Choose row:'
  row = gets.chomp.to_i
  puts 'Choose column:'
  col = gets.chomp.to_i

  move = current_board.make_move(row, col, current_player.tile)
  if move.nil?
    current_player.turn = true
  else
    move
    current_player.turn = false
  end
  p current_board.grid
end

def turn1?(player1, player2)
  player2.turn = if player1.turn
                   false
                 else
                   true
                 end
end

def turn2?(player1, player2)
  player1.turn = if player2.turn
                   false
                 else
                   true
                 end
end

play_game
