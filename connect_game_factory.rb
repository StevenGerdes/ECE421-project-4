require './contract'
require './connect4_checker'
require './token_generator'
require './opponent'

class ConnectGameFactory
  
  include Contract

	attr_reader :player_count

  class_invariant([])


  def initialize(mode, players)
    @player_count = 2
	PlayerGameMode = Struct.new(:token_generator, :win_condition)
	game_modes = Hash.new
  	game_mode[:connect4] = [
		PlayerGameMode.new(TokenGenerator.new('FF0000', 'r'), Connect4Checker.new('r')),
		PlayerGameMode.new(TokenGenerator.new('0000FF', 'b'), Connect4Checker.new('b')),
	]
	game_mode[:otto_toot] = [
		PlayerGameMode.new(TokenGenerator.new('FF0000', 'r'), Connect4Checker.new('r')),
		PlayerGameMode.new(TokenGenerator.new('0000FF', 'b'), Connect4Checker.new('b')),
	]

  	if( players == 1 )
		init_opponent
	end
  end

	def init_opponent
			Opponent.new(game_main, game_state, player_token_generator(2))
	end


  method_contract(
      #preconditions
      [lambda { |obj, player_num| player_num.respond_to?(:to_i) },
       lambda { |obj, player_num| player_num.to_i >= 1 },
       lambda { |obj, player_num| player_num.to_i <= obj.player_count }],
      #postconditions
      [lambda { |obj, result, player_num| result.respond_to?(:get_token) }])
  def player_token_generator(player_num)
    return game_mode[@mode][player_num - 1] 
  end

  method_contract(
      #preconditions
      [lambda { |obj, player_num| player_num.respond_to?(:to_i) },
       lambda { |obj, player_num| player_num.to_i >= 0 },
       lambda { |obj, player_num| player_num.to_i <= obj.player_count }],
      #postconditions
      [lambda { |obj, result, player_num| result.respond_to?(:check_win) }])
  def player_win_condition_checker(player_num)
  	return game_mode[@mode][player_num - 1]
  end

  def player_win_condition_checkers
    (1..@player_count).map { |player| player_win_condition_checker(player) }
  end

  def game_state
	@game_state = GameState.new if @game_state.nil?
	return @game_state
  end


end
