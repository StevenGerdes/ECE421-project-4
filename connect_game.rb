require './game_state'

class ConnectGame

  attr_accessor :on_win, :on_quit, :on_play
  attr_reader :game_state

  def initialize(game_state, token_generators)
    @on_win = SimpleEvent.new
    @on_quit = SimpleEvent.new
    @on_play = SimpleEvent.new
    @game_state = game_state
    @token_generators = token_generators
  end

  def play(column)
    unless @game_state.column_full?(column)
      @game_state.play(@token_generators[@game_state.player_turn - 1].get_token, Coordinate.new(@game_state.height(column), column))
      @on_play.fire
    end
  end

end