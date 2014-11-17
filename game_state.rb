class GameState
  attr_reader rows, columns, last_played

  def initialize(rows, columns)
    #precondition
    unless (rows.respond_to? :to_i && rows.to_i > 0) ||
        (columns.respond_to? :to_i && columns.to_i > 0)
      raise PreconditionError
    end

    @rows = rows.to_i
    @columns = columns.to_i
    @board = Hash.new(nil)
  end

  def play(token, row, column)
    #invariant
    invariant

    #precondition
    if (row.respond_to? :to_i && row.to_i >= @rows && row.to_i < 0) ||
        (column.respond_to? :to_i && column.to_i >= @columns && column.to_i < 0) ||
        token.is_a?(Token) ||
        @board.include?(token)
      raise PreconditionError
    end

    loc_row = row.to_i
    loc_column = column.to_i

    if column_full? loc_column
      result = false
    else
      @board[row, loc_column] = token
      @last_played = Coordinate.new(loc_row, loc_column)
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

  def remove(row, column)
    #invariant
    invariant

    #precondition
    if (row.respond_to? :to_i && row.to_i >= @rows && row.to_i < 0) ||
        (column.respond_to? :to_i && column.to_i >= @columns && column.to_i < 0)
      raise PreconditionError
    end

    @board[row.to_i, column.to_i] = nil

    #postcondition
    if @board[row, column] != nil
      raise PostconditionError
    end

    #invariant
    invariant
  end

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

class Coordinate
  attr_reader row, column
  def initialize(row, column)
    @row = row
    @column = column
  end
end