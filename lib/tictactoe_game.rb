require_relative '../lib/tictactoe_board'
require_relative '../lib/tictactoe_player'
require_relative '../lib/Array'

class TicTacToe_Game
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
end
