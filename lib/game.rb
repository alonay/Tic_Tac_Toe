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

  def available?(index)
    @board.state[index].class == Fixnum
  end

  def win?
    if @turns >= 4 && (!available?(0) || !available?(4) || !available?(8))
      return check_groupings
    end
  end

  def check_groupings
    groups = @board.state.each_slice(3).to_a
    groups.each do |current_group|
      if current_group[0] == current_group[1] && current_group[1] == current_group[2]
        return true
      end
    end

    # groups = [
    #   [0,1,2],
    #   [3,4,5],
    #   [6,7,8]
    # ]

    (0..2).each do |vertical|
      if groups[0][vertical] == groups[1][vertical] && groups[1][vertical] == groups[2][vertical]
        return true
      end
    end

    if @board.state[4] == @board.state[0] && @board.state[0] == @board.state[8] || @board.state[4] == @board.state[2] && @board.state[2] == @board.state[6]
      return true
    end
    return false
  end

  # def win?
  #   win_combos = [
  #   [0, 1, 2], [3, 4, 5], [6, 7, 8],
  #   [0, 3, 6], [1, 4, 7], [2, 5, 8],
  #   [0, 4, 8], [2, 4, 6]
  #   ]
  #   # @state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  #             # 0  1  2  3  4  5  6  7  8
  #
  #   win_combos.each do |win_combo|
  #     if available?(win_combo[0])
  #       if win_combo[0] && @board.state[win_combo[0]] == @board.state[win_combo[1]] && @board.state[win_combo[1]] == @board.state[win_combo[2]]
  #         return true
  #       end
  #     end
  #   end
  # end
end
