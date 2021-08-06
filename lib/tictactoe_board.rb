require_relative '../lib/Array'

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