class TicTacToe

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  WIN_COMBINATIONS =
  [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right column
  [6,4,2],  # Diagonal 1
  [0,4,8]   # Diagonal 2
  ]         # creating a nested array for each win combination

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
     # define a method into which we can pass user input in the form of a string (1,5,etc).
     # return the corresponding index of the board.
     index = input.to_i - 1
  end

  def move(index, player = "X")
    @board[index] = player
  end

  def position_taken?(index)
    # responsible for evalauting users desired move and checking to see if position is already occupied.
    # method runs after input_to_index
    @board[index] != " "
  end

  def valid_move?(index)
    index < 9 && !position_taken?(index)
  end

  def current_player
    #use the turn_count method to determine if it is "X" or "O's" turn
    turn_count.even? ? "X" : "O"
  end

  def turn
     puts "Please enter 1-9:"
     user_input = gets.strip
     index = input_to_index(user_input)
     if valid_move?(index)
       move(index, current_player)
     else
       turn
       display_board
     end
   end

  def turn_count
  #returns the number of turns that have been played based on the board variable
  #@board.count("X") + @board.count("O")
  @board.count {|square| square != " "}
  end

  def won?
    # will need to iterate through the win combinations
    # WIN_COMBINATIONS will access the elements of the @board array
    # use find to return the first combination for which the condition is true, nil if none are
    WIN_COMBINATIONS.find do |combo|
      # combo is an array of index numbers
      # access one index number at a time to access that index of the board
      # compare and see if all equal/have the same token
      # need to make sure not all empty string by using position_taken too
      position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
    end
  end

    def full?
      @board.all? do |x|
        x != " "
    end
  end

    def draw?
      !won? && full?
    end

    def over?
      won? || draw?
    end

    def winner(board)
      won = won?(board)
      if won != nil
        return board[won[0]]
      end
    end

    def play
      while !over?
        turn
      end
      if won?
        @winner = winner
        puts 'Congratulations ' + @winner + "!"
      elsif draw?
        puts "Cat's Game!"
      end
    end
  end

#newgame = TicTacToe.new
#newgame.play
