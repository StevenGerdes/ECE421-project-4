#Setting debug to true will set it in debug code. One of the things that happens
#is a debug console will run
$DEBUG = true
require './game_main'
game = GameMain.new()

#if ui isn't on the game won't start unless you do it yourself
if $DEBUG
  game.start_game(2, :otto_toot)
end

