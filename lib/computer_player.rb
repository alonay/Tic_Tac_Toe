require_relative '../lib/player.rb'

class ComputerPlayer < Player
  def set_choice(humans_choice)
    if humans_choice == "O"
      @choice = "X"
    else
      @choice = "O"
    end
  end

  def play(current_board)
    puts "ok it's my turn!"# returns a random choice from available_spaces
    open_spaces = current_board.select{|spot| spot.class == Fixnum}
    selection = open_spaces.sample
    puts "I pick #{selection}!"
    selection
  end
end
