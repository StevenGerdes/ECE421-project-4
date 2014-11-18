require './contract'

class ConnectGameFactory
  include Contract

  class_invariant([])


  def initialize(players, type)
    @player_count = players
  end

  method_contract(
      #preconditions
      [lambda { |obj, player_num| player_num.respond_to?(:to_i) },
       lambda { |obj, player_num| player_num.to_i > 0 }],
      #postconditions
      [lambda { |obj, result, player_num| result.respond_to?(:get_token) }])

  def player_token_generator(player_num)
    result = nil
  end

  method_contract(
      #preconditions
      [lambda { |obj, player_num| player_num.respond_to?(:to_i) },
       lambda { |obj, player_num| player_num.to_i > 0 }],
      #postconditions
      [lambda { |obj, result, player_num| result.respond_to?(:check_win) }])

  def player_win_condition_checker(player_num)
    result = nil
  end

  def player_win_condition_checkers
    (0..@player_count).map { |player| player_win_condition_checker(player) }
  end

end