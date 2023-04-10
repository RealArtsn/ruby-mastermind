# Row on game board
class Row
  def initialize
    @code_pegs = [0, 0, 0, 0]
    @key_pegs = {}
  end
  attr_reader :code_pegs
end

# Board containing rows
class Board
  def initialize
    row_count = 12
    # create rows
    @rows = Array.new(row_count) { Row.new }
  end
  attr_reader :rows

  # override string representation to return board
  def to_s
    string = ''
    rows.each do |row|
      # add array to string, replacing comma and brackets
      string += "#{row.code_pegs}\n".gsub(',', '').gsub(/[\[|\]|]/, '|')
    end
    string
  end
end

class Codemaker
end

class Codebreaker
end

class Round
end
