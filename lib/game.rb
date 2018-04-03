require_relative '../lib/board.rb'
require_relative '../lib/computer_player.rb'
require_relative '../lib/human_player.rb'

class Game
  def initialize
    @board = Board.new
    @human_player = HumanPlayer.new
    @computer_player = ComputerPlayer.new
    @turns = 0
  end
  def input_to_board_and_repeat
    if @turns.even?
      puts "Please enter a number (1-9):"
      input = gets.strip

      return if input == 'exit'

      index = input.to_i - 1

      if @board.state[index].class == Fixnum
        @board.state[index] = "x"
        @board.show
        @turns += 1
        input_to_board_and_repeat
      else
        puts "Please pick another spot, remember than open spots are represented as numbers on the board"
      end
    else
      comp_choice = @computer_player.play(@board.state)
      index = comp_choice.to_i - 1
          @board.state[index] = "O"
          @board.show
          @turns += 1
          input_to_board_and_repeat
      end
  end
end
