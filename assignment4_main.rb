require './game_main'

#Setting debug to true will set it in debug code. One of the things that happens
#is a debug console will run
$DEBUG = false

#you can start the game with the ui off. This only makes sense if debug is on
$UI = true
game = GameMain.new()

#if ui isn't on the game won't start unless you do it yourself
unless $UI
    game.start_game(2, :connect4)
end

