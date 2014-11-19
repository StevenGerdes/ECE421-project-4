require './simple_event'
require './command_view'
require './connect_game_factory'

unless $DEBUG
  require './start_view'
  require './game_view'
end

class GameMain

  def initialize()
    StartView.new(self) unless $DEBUG
  end

  def start_game(players, type)
    game_factory = ConnectGameFactory.new(players, type)

    GameView.new(game_factory.connect_game, game_factory.game_state) unless $DEBUG

    CommandView.new(game_factory) if $DEBUG
  end


end
