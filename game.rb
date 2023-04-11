# manage player inputs
module Inputs
  # get four digit number from player input
  def receive_numbers
    loop do
      puts 'Enter a four digits between 1 and 6:'
      # extract only numbers from input
      input = gets.gsub(/[^1-6]/, '').split('').map(&:to_i)
      # return from loop if input is correct length
      return input unless input.length != 4
    end
  end
end

# Row on game board
class Row
  def initialize
    @code = [0, 0, 0, 0]
    @key = { num_match: 0, position_match: 0 }
  end
  attr_reader :code, :key

  # update row to match guess
  def update_code(guess)
    guess.each_with_index do |n, idx|
      code[idx] = n
    end
  end

  def update_key(goal)
    matched = []
    unique_guess = code.uniq
    goal.each_with_index do |goal_num, idx|
      guess_num = code[idx]
      # tally positional matches
      if guess_num == goal_num
        key[:position_match] += 1
        next
      end
      matched.push(guess_num)
      # tally other non-positional matches
      if matched.count(guess_num) <= goal.count(guess_num)
        key[:num_match] += 1
      end
    end
  end

  def to_s
    # return string representation of array, replacing commas and brackets
    key_s = ''
    key_s += 'i' * key[:num_match]
    key_s += 'I' * key[:position_match]
    "#{code} #{key_s}\n".gsub(',', '').gsub(/[\[|\]|]/, '|')

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

  # check if input code is winner
  def winner?(in_code)
    code == in_code
  end

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

  # generate a code
  def generate_code
    generated = ''
    for _ in 1..4
      generated += (rand(6) + 1).to_s
    end
    generated.split('').map &:to_i
  end
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
    set_board_code(codemaker.generate_code)
    # iterate through rows until a correct answer is provided
    puts board
    board.rows.each do |row|
      guess = codebreaker.prompt_guess
      row.update_code(guess)
      row.update_key(board.code)
      puts board
      # break and print winner if guess is correct
      winner = board.winner?(guess)
      next unless winner

      puts 'Codebreaker guessed the code!'
      return
    end
    puts "You lose! The code was #{board.code.to_s.gsub(',','')}."
  end

  # prompt player for code and set board for game
  def set_board_code(code)
    code.each_with_index do |n, idx|
      board.code[idx] = n
    end
  end
end

round = Round.new
round.start
