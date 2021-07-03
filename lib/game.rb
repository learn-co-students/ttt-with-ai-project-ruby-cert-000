class Game
  extend Players
  require 'pry'

  attr_accessor :player_1, :player_2, :board

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  attr_reader :current_player

  def initialize (player_1 = nil, player_2 = nil, board = nil)
    player_1 ? @player_1 = player_1 : @player_1 = Players::Human.new("X")
    player_2 ? @player_2 = player_2 : @player_2 = Players::Human.new("O")
    board ? @board=board :@board = Board.new
    @current_player = @player_1
 end

 def over?
   won? || draw?
 end

 def won?
   Game::WIN_COMBINATIONS.detect do |win_combo|
      @board.cells[win_combo[0]] == @board.cells[win_combo[1]] &&
      @board.cells[win_combo[1]] == @board.cells[win_combo[2]] &&
      @board.taken?(win_combo[0]+1)
    end

 end

 def draw?
   @board.full? && !won?
 end

 def winner
  if winning_combo = won?
    @winner = @board.cells[winning_combo.first]
  end
 end

 def turn
  input = "invalid"
    while !@board.valid_move?(input)
    print "\nPlease enter a position from 1 to 9 (Player #{@current_player.token}): "
      input = @current_player.move(@board)
    end
    @board.update(input, @current_player)
    @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
 end

 def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{self.winner}!"
    else draw?
      puts "Cat's Game!"
    end
  end




end
