class GameState
  attr_reader rows, columns, last_played

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @board = Array.new(rows)
    @board.map! { Array.new(columns) }
  end

  def play(token, row, column)
    #invariant
    invariant

    #precondition
    if row > @rows ||
        column > @columns ||
        token.is_a?(Token) ||
        @board.include?(token)
      raise PreconditionError
    end

    #postcondition
    if !@board.include?(token)
      raise PostconditionError
    end

    #invariant
    invariant
  end

  def height(column)
    #invariant
    invariant

    #postcondition
    if result > @rows ||
        result < 0 ||
        !result.nil?
      raise PostconditionError
    end

    #invariant
    invariant
  end

  private
  def invariant
    if @rows < 0 ||
        @columns < 0
      raise InvarientError
    end
  end
end