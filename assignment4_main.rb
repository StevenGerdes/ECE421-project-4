#Setting debug to true will set it in debug code. One of the things that happens
#is a debug console will run
$DEBUG = true
require './game_main'
game = GameMain.new()

#if ui isn't on the game won't start unless you do it yourself
<<<<<<< HEAD
unless $UI
    game.start_game(1, :connect4)
=======
if $DEBUG
  game.start_game(2, :otto_toot)
>>>>>>> 8ad35aba4c3985445fa70d6bedbe6e403d18f2ea
end