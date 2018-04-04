require_relative '../lib/player.rb'

class HumanPlayer < Player
  def set_choice(input)
    if input.upcase == "X" || input.upcase == "O"
      @choice = input
      return @choice.upcase
    else
      puts "that isn't an option"
      set_choice(gets.strip)
    end
  end

  def play
    puts "Please enter a number (1-9):"
    gets.strip
  end
end
