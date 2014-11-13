require './contract_exceptions'
class GameMain

  @player_turn = 0

  def setup_game

    invariant

  end

  def on_mouse_move

    invariant

  end

  def end_game(winner)

    invariant

    #postcondition
    #application exits
  end

  private
  def invariant
    unless @column_index.respond_to?(:to_i) &&
        @column_index >= -1 && # -1 means no column selected
        @column_index < @game_state.columns
      raise PreconditionError
    end
  end

end