require './contract_exceptions'

class WinConditionChecker
  def check_win(game_state)
    #invariant
    original_state = game_state.clone

    #precondition
    unless game_state.respond_to?(:get_rows) &&
        game_state.respond_to?(:get_cols) &&
        game_state.respond_to?(:last_played)
      raise PreconditionError;
    end

    last_token = game_state.at(game_state.last_played)
    result = four_in_row(game_state.row(game_state.last_played.row), last_token.value) ||
        four_in_row(game_state.column(game_state.last_played.column), last_token.value) ||
        four_in_row(game_state.left_diagonal(game_state.last_played), last_token.value) ||
        four_in_row(game_state.right_diagonal(game_state.last_played), last_token.value)


    #invariant
    if original_state != game_state
      raise InvarientError;
    end

    result

  end

  def four_in_row(array, value)
    num_in_row = 0
    array.each do |token|
      if token.value == value
        num_in_row += 1
        return true if num_in_row == 4
      else
        num_in_row = 0
      end
    end

    return false
  end


end