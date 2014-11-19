require './contract'
class Opponent

  include Contract

  class_invariant([lambda { |obj| !@game_main.nil? },
                   lambda { |obj| !@game_state.nil?}])

  method_contract(
      #preconditions
      [lambda { |obj, game_main, game_state, token_generator| token_generator.respond_to?(:get_token)},
       lambda { |obj, game_main, game_state| game_main.respond_to?(:play)},
       lambda { |obj, game_main, game_state| game_state.respond_to?(:on_turn_change)},
       lambda { |obj, game_main, game_state| game_state.respond_to?(:player_turn)}],
      #postconditions
      [])

  def initialize(game_main, game_state, token_generator)
    @game_state = game_state
    game_state.on_turn_change.listen{
      if game_state.player_turn == 2
        game_main.play(token_generator.get_token, self.play)
      end
    }
  end

  method_contract(
      #preconditions
      [lambda { |obj| !@game_state.is_full?}],
      #postconditions
      [lambda { |obj, result | result.respond_to?(:to_i)},
       lambda { |obj, result | result.to_i < @game_state.columns}])

  #Chooses a column to play in at random for the AI
  def play
    result = rand(@game_state.columns - 1)
    while @game_state.column_full?(result)
      result = rand(@game_state.columns - 1)
    end

    return result
  end
end
