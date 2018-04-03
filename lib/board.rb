class Board
  def initialize
    @state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def available_spaces
    @state.select { |space| space.class == Fixnum }
  end

  def state
    @state
  end

  def show
    puts "
        #{@state[0]}  ||  #{@state[1]}  ||  #{@state[2]}
      ===================
        #{@state[3]}  ||  #{@state[4]}  ||  #{@state[5]}
      ===================
        #{@state[6]}  ||  #{@state[7]}  ||  #{@state[8]}
    "
  end
end
