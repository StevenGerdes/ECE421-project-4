class GameState
  attr_reader rows, columns, last_played

  def initialize(rows, columns, win_cond_checker)
    #precondition
    unless (rows.respond_to? :to_i && rows.to_i > 0) ||
        (columns.respond_to? :to_i && columns.to_i > 0) ||
        win_cond_checker.is_a?(WinConditionChecker)
      raise PreconditionError
    end

    @rows = rows.to_i
    @columns = columns.to_i
    @board = Hash.new(nil)
    @win_condition_checker = win_cond_checker
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
      @board[coordinate.row, coordinate.column] = token
      @last_played = Coordinate.new(coordinate.row, coordinate.column)
      result = true
    end

    #postcondition
    if !@board.include?(token)
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

    @board[coordinate.row, coordinate.column] = nil

    #postcondition
    if @board[coordinate.row, coordinate.column] != nil
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
      if @board[i, column].nil?
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

  def reset

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
  attr_reader row, column

  def initialize(row, column)
    #precondition
    unless (row.respond_to? :to_i && row.to_i > 0) ||
        (column.respond_to? :to_i && column.to_i > 0)
      raise PreconditionError
    end

    @row = row.to_i
    @column = column.to_i
  end
end