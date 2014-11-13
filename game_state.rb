class GameState
  attr_reader rows, columns, last_played

  def initialize(rows, columns)
    #precondition
    unless (rows.respond_to? :to_i && rows.to_i > 0) ||
        (columns.respond_to? :to_i && columns.to_i > 0)
      raise PreconditionError
    end

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

    result = nil
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