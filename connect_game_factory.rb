require './contract'
require './connect4_checker'
require './token_generator'
require './game_state'
require './opponent'
require './connect_game'

class ConnectGameFactory

  include Contract

  attr_reader :player_count

  class_invariant([])

  PlayerGameMode = Struct.new(:token_generator, :win_condition)

  def initialize(players, mode)
    @player_count = 2
    @mode = mode

    @game_mode = Hash.new
    @game_mode[:connect4] = [
        PlayerGameMode.new(TokenGenerator.new('FF0000', 'r'), Connect4Checker.new('r')),
        PlayerGameMode.new(TokenGenerator.new('0000FF', 'b'), Connect4Checker.new('b')),
    ]
    @game_mode[:otto_toot] = [
        PlayerGameMode.new(TokenGenerator.new('FF0000', 'r'), Connect4Checker.new('r')),
        PlayerGameMode.new(TokenGenerator.new('0000FF', 'b'), Connect4Checker.new('b')),
    ]

    connect_game.on_play.listen {
      player_win_condition_checkers.each_with_index { |checker, index|
        if checker.check_win(game_state)
          connect_game.on_win.fire(index)
        end
      }
    }
    connect_game.on_win.listen { game_state.reset }

    if players == 1
      init_opponent
    end
  end

  def connect_game
    @connect_game = ConnectGame.new(game_state, player_token_generators) if @connect_game.nil?
    @connect_game
  end


  method_contract(
      #preconditions
      [lambda { |obj, player_num| player_num.respond_to?(:to_i) },
       lambda { |obj, player_num| player_num.to_i >= 1 },
       lambda { |obj, player_num| player_num.to_i <= obj.player_count }],
      #postconditions
      [lambda { |obj, result, player_num| result.respond_to?(:get_token) }])

  def player_token_generator(player_num)
    @game_mode[@mode][player_num - 1].token_generator
  end

  method_contract(
      #preconditions
      [lambda { |obj, player_num| player_num.respond_to?(:to_i) },
       lambda { |obj, player_num| player_num.to_i >= 0 },
       lambda { |obj, player_num| player_num.to_i <= obj.player_count }],
      #postconditions
      [lambda { |obj, result, player_num| result.respond_to?(:check_win) }])

  def player_win_condition_checker(player_num)
    @game_mode[@mode][player_num - 1].win_condition
  end

  def player_win_condition_checkers
    (1..@player_count).map { |player| player_win_condition_checker(player) }
  end

  def player_token_generators
    (1..@player_count).map { |player| player_token_generator(player) }
  end

  def game_state
    if @game_state.nil?
      @game_state = GameState.new(@player_count, 6, 7)
    end
    @game_state
  end

  private

  def init_opponent
    Opponent.new(connect_game, game_state)
  end


end
