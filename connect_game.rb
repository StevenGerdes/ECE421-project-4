require './game_state'

class ConnectGame

  attr_accessor :on_win, :on_quit
  attr_reader :game_state

  def initialize(game_state)
    @on_win = SimpleEvent.new
    @on_quit = SimpleEvent.new
    @game_state = game_state
  end

  def play(token, column)
    unless @game_state.column_full?(column)
      @game_state.play(token, Coordinate.new(@game_state.height(column), column))
    end
  end

end