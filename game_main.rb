require './simple_event'
require './command_view'
require './start_view'
require './game_view'

class GameMain

  attr_accessor :on_win, :on_quit
  attr_reader :game_state

  def initialize(ui_on)
    @on_win = SimpleEvent.new
    @on_quit = SimpleEvent.new

    StartView.new
  end

  def start_game(game_factory)
    win_checkers = game_factory.player_win_condition_checkers
    @game_state = game_factory.game_state

    @on_win.listen{ game_state.reset }

    @game_state.on_change.listen {
      win_checkers.each_with_index { |checker, index|
        if checker.check_win(game_state)
          @on_win.fire(index)
        end
      }
    }
	
	GameView.new(game_main, game_state)	

    Thread.new{ CommandView.new(game_factory, self, game_state)} if $DEBUG
  end

  def play(token, column)
    unless @game_state.column_full(column)
      @game_state.play(token, @game_state.height, column)
    end
  end

end
