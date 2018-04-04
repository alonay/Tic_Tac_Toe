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

  def play
    until win? do
      if @turns.even?
        human_move = move_human_player
        break if human_move == 'exit'
      else
        break if @turns >= 8
        move_computer_player
      end
    end

    game_over unless human_move == 'exit'
  end

  # methods from here down are alphabetical

  def announce_winner
    if !win?
      puts 'Not gonna lie; it is a TIE!'
    elsif @turns.odd?
      puts "You beat me! There was something in my eye. I couldn't see!"
    else
      puts "BOOOM! I WON! THIS IS INSANE! ... I mean ... Good game!"
    end
  end

  def available?(index)
    @board.state[index].class == Fixnum
  end

  def choose_letter(input)
    @human_player.set_choice(input.upcase)
    puts "#{@human_player.choice} is your letter; does it get any better?! If it does and you've gotta go, type 'Exit' to let me know."
    @computer_player.set_choice(@human_player.choice)
  end

  def check_groupings
    # Groups current board to iterate and check for a win
    # The group is a multidimensional array of depth 2 and length 3
    # 3 nested arrays each with a length of 3
    groups = @board.state.each_slice(3).to_a

    if horizontal(groups) || vertical(groups) || diagonal(groups)
      true
    end
  end

  def diagonal(groups)
    # Checks for a diagonal win using the groups created
    # This win condition is met when one value ('X' or 'O') is present in each
    # index along one of the two diagonals
    return true if first_diagonal? || second_diagonal?
  end

  def enough_turns_played?
    @turns >= 4
  end

  def first_diagonal?
    @board.state[4] == @board.state[0] && @board.state[0] == @board.state[8]
  end

  def game_over
    announce_winner
    restart?
  end

  def greeting
    puts "Welcome to Tic Tac Toe, where you win by getting 3 in a row. Would you like to be the letter 'X' or the letter 'O'?"
    input = gets.strip
    choose_letter(input)
    play
  end

  def horizontal(groups)
    # Checks for a horizontal win using the groups created
    # This win condition is met when one value ('X' or 'O') is present at each
    # index within one of the nested arrays/rows
    groups.each do |current_group|
      if current_group[0] == current_group[1] && current_group[1] == current_group[2]
        return true
      end
    end

    false
  end

  def move_computer_player
    comp_choice = @computer_player.play(@board.state)
    index = comp_choice.to_i - 1
    @board.state[index] = @computer_player.choice
    @turns += 1
  end

  def move_human_player
    @board.show
    human_move = @human_player.play
    index = human_move.to_i - 1

    if human_move.downcase == 'exit'
      return 'exit'
    elsif index != -1 && available?(index)
      @board.state[index] = @human_player.choice
      @board.show
      @turns += 1
    else
      puts "Please pick another spot. Remember that open spots are represented as numbers on the board. This is the only way to score!"
      move_human_player
    end
  end

  def restart?
    puts "Good game, friend! Would you like to play again? Please type 'Yes' or 'No'. Soo...?"
    input = gets.strip

    if input.downcase == "yes"
      restart_game
    elsif input.downcase == "no"
      puts "Bye... I'm gonna cry :'( "
    else
      puts "This is like a game, just type 'Yes' or 'No'. Ready? Set? Go!"
      restart?
    end
  end

  def restart_game
    puts "What letter would you like to be this time? ... Did that even rhyme?"
    choose_letter(gets.strip)
    @board = Board.new
    @turns = 0
    play
  end

  def second_diagonal?
    @board.state[4] == @board.state[2] && @board.state[2] == @board.state[6]
  end

  def taken?(index)
    !available?(index)
  end

  def vertical(groups)
    # Checks for a vertical win using the groups created
    # This win condition is met when one value ('X' or 'O') is present at the
    # same index across all of the nested arrays (a column in the groups matrix)
    (0..2).each do |vertical|
      if groups[0][vertical] == groups[1][vertical] && groups[1][vertical] == groups[2][vertical]
        return true
      end
    end
    false
  end

  def win?
    if enough_turns_played? && winning_move_made? # A win can not happen before turn 5
      check_groupings
    end
  end

  def winning_move_made? # A win can not occur without at least one of these spaces filled
    taken?(0) || taken?(4) || taken?(8)
  end

end
