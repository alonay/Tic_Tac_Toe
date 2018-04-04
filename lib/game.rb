require_relative '../lib/board.rb'
require_relative '../lib/computer_player.rb'
require_relative '../lib/human_player.rb'

class Game
  def initialize
    @board = Board.new
    @human_player = HumanPlayer.new
    @computer_player = ComputerPlayer.new
    @human_player_coice = nil
    @turns = 0
  end

  def greeting
    puts "Hello, would you like to be the letter 'X' or the letter 'O'?"
    input = gets.strip
    @human_player.set_choice(input.upcase)
    puts "great! you are #{@human_player.choice}"
    @computer_player.set_choice(@human_player.choice)
    input_to_board_and_repeat
  end

  def input_to_board_and_repeat
    until win? == true
    if @turns.even?
      @board.show
      human_move = @human_player.play
      return if human_move == 'exit'
      index = human_move.to_i - 1

      if @board.state[index].class == Fixnum
        @board.state[index] = @human_player.choice
        @board.show
        @turns += 1
        # input_to_board_and_repeat
      else
        puts "Please pick another spot, remember than open spots are represented as numbers on the board"
        input_to_board_and_repeat
      end
    else
      comp_choice = @computer_player.play(@board.state)
      index = comp_choice.to_i - 1
          @board.state[index] = @computer_player.choice
          @turns += 1
        end
        input_to_board_and_repeat
    end
  end


  def win?
    win_combos = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
    ]
    # @state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
              # 0  1  2  3  4  5  6  7  8

    # @state = [1,2,3,4,5,6,7,8,9] -> any 3 a row are the same it's a win
    # if any 3 in a row separated by +3 are the same it's a win
    # if 0 and +4 and +4
    # if 2 and +2 and +2
    win_combos.each do |win_combo|
      if @board.state[win_combo[0]].class != Fixnum
        if win_combo[0] && @board.state[win_combo[0]] == @board.state[win_combo[1]] && @board.state[win_combo[1]] == @board.state[win_combo[2]]
          return true
        end
      end
    end
  end
end
