require './game_main'

$DEBUG = true
ui_on = false
game = GameMain.new(ui_on)

unless ui_on
    game.start_game(ConnectGameFactory.new(2, :connect4))
end

