# manage player inputs
module Inputs
  # get four digit number from player input
  def receive_numbers
    loop do
      puts 'Enter a four digits between 1 and 6:'
      input = gets.gsub(/[^1-6]/, '').split('').map(&:to_i)
      return input unless input.length != 4
    end
  end
end

# Row on game board
class Row
  def initialize
    @code = [0, 0, 0, 0]
    @key = {}
  end
  attr_reader :code, :key

  # update row to match guess
  def update(guess)
    guess.each_with_index do |n, idx|
      code[idx] = n
    end
  end

  def to_s
    # return string representation of array, replacing commas and brackets
    "#{code}\n".gsub(',', '').gsub(/[\[|\]|]/, '|')
  end
end

# Board containing rows
class Board
  def initialize
    row_count = 12
    # create rows
    @rows = Array.new(row_count) { Row.new }
    @code = [0, 0, 0, 0]
  end
  attr_reader :rows, :code

  # override string representation to return board
  def to_s
    string = ''
    rows.each do |row|
      # add row to string
      string += row.to_s
    end
    string
  end
end

# 'player' guessing the code
class Codemaker
  include Inputs
  # get code from player
  def prompt_code
    puts 'Pick a code.'
    code = receive_numbers
    puts "Code set to #{code}."
    code
  end
  # define generate_code method
end

# 'player' creating the code
class Codebreaker
  include Inputs
  # prompt player for four-number guess and return array
  def prompt_guess
    puts 'Take a guess.'
    guess = receive_numbers
    puts "You guessed #{guess}."
    guess
  end
end

# one round of the game (full board one time)
class Round
  def initialize
    @board = Board.new
    @codemaker = Codemaker.new
    @codebreaker = Codebreaker.new
  end
  attr_reader :codemaker, :codebreaker, :board

  def start
    set_board_code
    # iterate through rows until a correct answer is provided
    board.rows.each do |row|
      guess = codebreaker.prompt_guess
      row.update(guess)
      puts board
    end
  end

  # prompt player for code and set board for game
  def set_board_code
    code = codemaker.prompt_code
    code.each_with_index do |n, idx|
      board.code[idx] = n
    end
  end
end

round = Round.new
round.start
