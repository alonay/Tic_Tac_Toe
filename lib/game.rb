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

  def announce_winner
    if @turns.odd?
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
    puts "#{@human_player.choice} is your letter, does it get any better?!"
    @computer_player.set_choice(@human_player.choice)
  end

  def enough_turns_played?
    @turns >= 4
  end

  def greeting
    puts "The game is Tic Tac Toe, where you win by getting 3 in a row. Would you like to be the letter 'X' or the letter 'O'?"
    input = gets.strip
    choose_letter(input)
    play
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
    # break if human_move.upcase === 'EXIT'

    if human_move.downcase == 'exit'
      return 'exit'
    elsif !human_move.empty? && available?(index)
      @board.state[index] = @human_player.choice
      @board.show
      @turns += 1
    else
      puts "Please pick another spot, remember that open spots are represented as numbers on the board. This is the only way to score!"
      move_human_player
    end
  end

  def play
    until win? do
      if @turns.even?
        human_move = move_human_player
        break if human_move == 'exit'
      else
        move_computer_player
      end
    end

    unless human_move == 'exit'
      announce_winner
      restart?
    end
  end

  def restart?
    puts "Good game, friend, would you like to play again? please type 'Yes' or 'No'. Soo...?"
    input = gets.strip

    if input.downcase == "yes"
      puts "what letter would you like to be this time? ... did that even rhyme?"
      letter = gets.strip
      choose_letter(letter)
      restart_game
    elsif input.downcase == "no"
      puts "Bye i'm gonna cry :'( "
    else puts "This is like a game, choose yes or no, ready? set? go!"
      restart?
    end
  end

  def restart_game
    @board = Board.new
    @turns = 0
    play
  end

  def taken?(index)
    !available?(index)
  end

  def win?
    if enough_turns_played? && winning_move_made?
      return check_groupings
    end
  end

  def winning_move_made?
    taken?(0) || taken?(4) || taken?(8)
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
end
