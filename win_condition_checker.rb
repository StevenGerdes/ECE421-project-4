require './contract_exceptions'

class WinConditionChecker
  def check_win(game_state)
    #invariant
    original_state = game_state.clone;

    #precondition
    unless game_state.respond_to?(:get_rows) &&
        game_state.respond_to?(:get_cols) &&
        game_state.respond_to?(:last_played)
      raise PreconditionError;
    end

    #invariant
    if original_state != game_state
      raise InvarientError;
    end
  end
end