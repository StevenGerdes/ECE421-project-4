require './start_view'

#Setting debug to true will set it in debug code. One of the things that happens
#is a debug console will run
$DEBUG = true

#you can start the game with the ui off. This only makes sense if debug is on
ui_on = true
game = GameMain.new(ui_on)

#if ui isn't on the game won't start unless you do it yourself
unless ui_on
    game.start_game(ConnectGameFactory.new(2, :connect4))
end

