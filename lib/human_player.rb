require_relative '../lib/player.rb'

class HumanPlayer < Player
  def set_choice(input)
    if input == "X" || input == "O"
      @choice = input
      return @choice
    else
      puts "That isn't an option. You can do better, pick a letter."
      set_choice(gets.strip)
    end
  end

  def play
    puts "Please enter a number (1-9):"
    gets.strip
  end
end
