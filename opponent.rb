require './contract_exceptions'
class Opponent

  class_invariant([lamdba { |obj| !@tokenGenerator.nil? }])

  method_contract(
      #preconditions
      [lambda { |obj, game_state| game_state.respond_to?(:play)}],
      #postconditions
      [lambda { |obj, result, game_state | game_state.last_played.equal? result}])

  def play(game_state)

    #do some stuff to find
    token = @tokenGenerator.get_token
    coord = Coordinate.new(0,0)

    game_state.play(token, coord)

    return coord
  end
end