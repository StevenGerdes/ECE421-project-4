require './contract'
require './win_condition_checker'
require './token_generator'

class ConnectGameFactory
  include Contract

  class_invariant([])


  def initialize(players, type)
    @player_count = players
  end

  method_contract(
      #preconditions
      [lambda { |obj, player_num| player_num.respond_to?(:to_i) },
       lambda { |obj, player_num| player_num.to_i >= 0 }],
      #postconditions
      [lambda { |obj, result, player_num| result.respond_to?(:get_token) }])

  def player_token_generator(player_num)
    if player_num.to_i == 0
      color = 'FF0000'
      value = 'r'
    else
      color = '0000FF'
      value = 'b'
    end

    return TokenGenerator.new(color, value)

  end

  method_contract(
      #preconditions
      [lambda { |obj, player_num| player_num.respond_to?(:to_i) },
       lambda { |obj, player_num| player_num.to_i >= 0 }],
      #postconditions
      [lambda { |obj, result, player_num| result.respond_to?(:check_win) }])

  def player_win_condition_checker(player_num)
    if player_num.to_i == 0
      value = 'r'
    else
      value = 'b'
    end
    WinConditionChecker.new(value)
  end

  def player_win_condition_checkers
    (1..@player_count).map { |player| player_win_condition_checker(player) }
  end


end