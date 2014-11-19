require './game_state'

class ConnectGame

  attr_accessor :on_win, :on_quit, :on_play
  attr_reader :game_state, :title

  def initialize(title, game_state, players)
    @on_win = SimpleEvent.new
    @on_quit = SimpleEvent.new
    @on_play = SimpleEvent.new
    @title = title
    @game_state = game_state
    @players = players
  end

  def play(column)
    unless @game_state.column_full?(column)
      @game_state.play(@players[@game_state.player_turn - 1].token_generator.get_token, Coordinate.new(@game_state.height(column), column))
      @on_play.fire

      winner = false
      @players.each_with_index { |player, index|
        if player.win_condition.check_win(game_state)
          winner = true
          connect_game.on_win.fire(index + 1)
        end
      }
      if winner
        game_state.reset
      elsif !@game_state.is_full?
        game_state.change_turn
      end

    end
  end

end
