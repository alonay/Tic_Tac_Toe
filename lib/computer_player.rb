require_relative '../lib/board.rb'
class ComputerPlayer
  def play(current_board)
    puts "ok it's my turn!"# returns a random choice from available_spaces
    open_spaces = current_board.select{|spot| spot.class == Fixnum}
    selection = open_spaces.sample
    puts "I pick #{selection}!"
    selection
  end
end
