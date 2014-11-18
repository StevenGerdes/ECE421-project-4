require './contract'

class WinConditionChecker
  include Contract

  class_invariant([])

  method_contract(
      #preconditions
      [lambda { | obj, game_state| game_state.respond_to?(:row) },
       lambda { | obj, game_state| game_state.respond_to?(:column) },
       lambda { | obj, game_state| game_state.respond_to?(:left_diagonal) },
       lambda { | obj, game_state| game_state.respond_to?(:right_diagonal) },
       lambda { | obj, game_state| game_state.respond_to?(:last_played) }],
      #postconditions
      [lambda { | obj, result, game_state| result.is_a?(TrueClass)|| result.is_a?( FalseClass)}])

  def check_win(game_state)
    last_token = game_state.get_token(game_state.last_played)
    return four_in_row(game_state.row(game_state.last_played.row), last_token.value) ||
        four_in_row(game_state.column(game_state.last_played.column), last_token.value) ||
        four_in_row(game_state.left_diagonal(game_state.last_played), last_token.value) ||
        four_in_row(game_state.right_diagonal(game_state.last_played), last_token.value)
  end

  method_contract(
      #preconditions
      [],
      #postconditions
      [])

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