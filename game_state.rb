require './contract'

class GameState
  include Contract
  attr_reader :rows, :columns, :last_played, :player_turn, :on_change

  class_invariant([lambda { |obj| obj.rows > 0 },
                   lambda { |obj| obj.columns > 0 }])

  method_contract(
      #preconditions
      [lambda { |obj, rows, columns| rows.respond_to?(:to_i) },
       lambda { |obj, rows, columns| rows.to_i > 0 },
       lambda { |obj, rows, columns| columns.respond_to?(:to_i) },
       lambda { |obj, rows, columns| columns.to_i > 0 }],
      #postconditions
      [])

  def initialize(rows, columns)
    @rows = rows.to_i
    @columns = columns.to_i
    @player_turn = 1
    @board = Hash.new(nil)
    @on_change = SimpleEvent.new
  end

  method_contract(
      #preconditions
      [lambda { |obj, token, coordinate| coordinate.is_a? Coordinate },
       lambda { |obj, token, coordinate| coordinate.row < @rows && coordinate.row >= 0 },
       lambda { |obj, token, coordinate| coordinate.column < @columns && coordinate.column >= 0 },
       lambda { |obj, token, coordinate| token.is_a?(Token) },
       lambda { |obj, token, coordinate| !@board.include?(token) }],
      #postconditions
      [lambda { |obj, result, token, coordinate| @board.include?(token) }])
  #Sets a token to the specified coordinate
  def play(token, coordinate)

    if column_full? coordinate.column
      result = false
    else
      @board[[coordinate.row, coordinate.column]] = token
      @last_played = Coordinate.new(coordinate.row, coordinate.column)
      result = true
    end

    @on_change.fire

    return result
  end

  method_contract(
      #preconditions
      [lambda { |obj, coordinate| coordinate.is_a? Coordinate },
       lambda { |obj, coordinate| coordinate.row < @rows && coordinate.row >= 0 },
       lambda { |obj, coordinate| coordinate.column < @rows && coordinate.column >= 0 }],
      #postconditions
      [lambda { |obj, result, coordinate| @board[[coordinate.row, coordinate.column]] == nil }])
  # Remove token from board at coordinates
  def remove(coordinate)

    @board[[coordinate.row, coordinate.column]] = nil
    @on_change.fire

  end


  method_contract(
      #preconditions
      [],
      #postconditions
      [lambda { |obj, result, column| result <= @rows },
       lambda { |obj, result, column| result >= 0 }])
  # Get the highest row that contains a token in the supplied column
  def height(column)
    result = 0

    for i in 0..@rows - 1
      if @board[[i, column]].nil?
        result = i
      end
    end

    return result
  end

  #reset game state to original state
  def reset
    @player_turn = 1
    @board = Hash.new(nil)
    @last_played = nil
  end

  #prints out game board as a string
  def to_s

    result = 'Rows: ' & @rows.to_s & "\n" &
        'Columns: ' & @columns.to_s & "\n" &
        'Players turn: ' & @player_turn.to_s & "\n" &
        'Last Played: ' & @last_played.to_s & "\n"

    for i in 0..@rows - 1
      row_matrix = row i
      for j in 0..@columns
        if row_matrix[j].nil?
          result = result & '-'
        else
          result = result & row_matrix[j].to_s
        end
      end
      result = result & '/n'
    end

  end

  def row(i)
    @board[i].product((0..@columns - 1).to_a).collect { |index| @board[index] }
  end

  private
  def column_full?(column)
    if @board[[@rows - 1][column]] != nil
      return true
    end
    return false
  end
end

#Class to keep track of token coordinates
class Coordinate
  include Contract
  attr_reader :row, :column

  class_invariant([])

  method_contract(
      #preconditions
      [lambda{ |obj, row, column| row.respond_to? :to_i && row.to_i > 0},
       lambda{ |obj, row, column| column.respond_to? :to_i && column.to_i > 0}],
      #postconditions
      [])

  def initialize(row, column)
    @row = row.to_i
    @column = column.to_i
  end

  def to_s
    @row.to_s & ', ' & @column.to_s
  end
end