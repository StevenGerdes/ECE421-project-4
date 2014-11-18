class GameState
  attr_reader :rows, :columns, :last_played, :player_turn, :on_change

  def initialize(rows, columns)
    #precondition
    unless (rows.respond_to?(:to_i) && rows.to_i > 0) ||
        (columns.respond_to?(:to_i) && columns.to_i > 0)
      raise PreconditionError
    end

    @rows = rows.to_i
    @columns = columns.to_i
    @player_turn = 1
    @board = Hash.new(nil)
    @on_change = SimpleEvent.new
  end

  #Sets a token to the specified coordinate
  def play(token, coordinate)
    #invariant
    invariant

    #precondition
    if (!coordinate.is_a? Coordinate) ||
        (coordinate.row >= @rows && coordinate.row < 0) ||
        (coordinate.column >= @columns && coordinate.column < 0) ||
        token.is_a?(Token) ||
        @board.include?(token)
      raise PreconditionError
    end

    if column_full? coordinate.column
      result = false
    else
      @board[[coordinate.row, coordinate.column]] = token
      @last_played = Coordinate.new(coordinate.row, coordinate.column)
      result = true
    end

    @on_change.fire

    #postcondition
    unless @board.include?(token)
      raise PostconditionError
    end

    #invariant
    invariant

    return result
  end

  # Remove token from board at coordinates
  def remove(coordinate)
    #invariant
    invariant

    #precondition
    if !(coordinate.is_a? Coordinate) ||
        (coordinate.row >= @rows && coordinate.row < 0) ||
        (coordinate.column >= @columns && coordinate.column < 0)
      raise PreconditionError
    end

    @board[[coordinate.row, coordinate.column]] = nil
    @on_change.fire

    #postcondition
    if @board[[coordinate.row, coordinate.column]] != nil
      raise PostconditionError
    end

    #invariant
    invariant
  end

  # Get the highest row that contains a token in the supplied column
  def height(column)
    #invariant
    invariant

    result = 0

    for i in 0..@rows - 1
      if @board[[i, column]].nil?
        result = i
      end
    end

    #postcondition
    if result > @rows ||
        result < 0 ||
        !result.nil?
      raise PostconditionError
    end

    #invariant
    invariant

    return result
  end

  #reset game state to original state
  def reset
    #invariant
    invariant

    @player_turn = 1
    @board = Hash.new(nil)
    @last_played = nil

    #invariant
    invariant
  end

  #prints out game board as a string
  def to_s
    #invariant
    invariant

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

    #invariant
    invariant
  end

  def row(i)
    @board[i].product((0..@columns - 1).to_a).collect { |index| @board[index] }
  end

  private
  def invariant
    if @rows < 0 ||
        @columns < 0
      raise InvarientError
    end
  end

  def column_full?(column)
    if @board[[@rows - 1][column]] != nil
      return true
    end
    return false
  end
end

#Class to keep track of token coordinates
class Coordinate
  attr_reader :row, :column

  def initialize(row, column)
    #precondition
    unless (row.respond_to? :to_i && row.to_i > 0) ||
        (column.respond_to? :to_i && column.to_i > 0)
      raise PreconditionError
    end

    @row = row.to_i
    @column = column.to_i
  end

  def to_s
    @row.to_s & ', ' & @column.to_s
  end
end