require './contract_exceptions'
require './simple_event'
require './game_state'
require './connect_game_factory'

class GameMain

  attr_reader on_win, on_quit
  def initialize( debugging )
    @on_win = SimpleEvent.new
    @on_quit = SimpleEvent.new

    connect_game_factory = ConnectGameFactory.new(2, :connect4)
    win_checkers = connect_game_factory.player_win_condition_checkers
    game_state = GameState.new(6, 7)

    game_state.on_change.listen {
      win_checkers.each_with_index { |checker, index|
        if checker.check_win(game_state)
          @on_quit.fire(index)
        end
      }
    }

    unless debugging
      return
    end

    command_view = CommandView.new( connect_game_factory, game_state, self)
    command_view.start

  end

end