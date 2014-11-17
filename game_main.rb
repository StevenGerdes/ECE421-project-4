require './contract_exceptions'
class GameMain

  @player_turn = 0
  attr_reader win_event
  def initialize( debugging )
    @win_event = SimpleEvent.new

    connect_game_factory = ConnectGameFactory.new(2, :connect4)
    win_checkers = connect_game_factory.player_win_condition_checkers
    game_state = GameState.new(6, 7)

    game_state.on_change.listen {
      win_checkers.each_with_index { |checker, index|
        if checker.check_win(game_state)
          @win_event.fire(index)
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