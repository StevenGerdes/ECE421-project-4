require './contract_exceptions'
class Opponent
  def play(game_state)
    invariant
    unless game_state.respond_to?(:play)
      raise PreconditionError
    end

    #do some stuff to find
    token = @tokenGenerator.get_token
    row = nil
    column = nil


    game_state.play( token, row, column )


    invariant

    unless game_state.last_played.equal? token
      raise PostconditionError
    end

  end

  private
  def invariant
    if @tokenGenerator.nil?
      raise InvarientException
    end
  end
end