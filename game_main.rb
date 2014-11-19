require './simple_event'
require './command_view'
require './connect_game_factory'
require './start_view' 
require './game_view' 

class GameMain

  def initialize()
    StartView.new(self) if $UI
  end

  def start_game(players, type)
    game_factory = ConnectGameFactory.new(players, type)

    GameView.new(game_factory.connect_game) if $UI

    CommandView.new(game_factory) if $DEBUG
  end



end
