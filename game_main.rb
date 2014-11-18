require './simple_event'
require './game_state'
require './connect_game_factory'
require './command_view'

class GameMain

  attr_accessor :on_win, :on_quit

  def initialize
    @on_win = SimpleEvent.new
    @on_quit = SimpleEvent.new
  end

  def start

    players = 2
    connect_game_factory = ConnectGameFactory.new(players, :connect4)
    win_checkers = connect_game_factory.player_win_condition_checkers
    game_state = GameState.new(players, 6, 7)

    @on_win.listen{ game_state.reset }

    game_state.on_change.listen {
      win_checkers.each_with_index { |checker, index|
        if checker.check_win(game_state)
          @on_win.fire(index)
        end
      }
    }

    command_view = CommandView.new(connect_game_factory, self, game_state)
    command_view.start
  end

end