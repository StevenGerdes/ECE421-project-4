require 'optparse'
class CommandView

  @running = true

  def initialize( game_factory, game_main, game_state)
    @game_factory = game_factory
    @game_main = game_main
    @game_state = game_state

    @cmd_parser = opt_parser = OptionParser.new do |opts|
      opts.on( '-d', '--display', 'display the game board') do
        puts @game_state.to_s
      end

      opts.on('-c', Integer, 'display current player' ) do
        puts @game_state.current_player.to_s
      end

      opts.on( '-p number,row,column', '--play x,y,z', Array, 'Play token for player at coordinates') do |arg_list|
        @game_state.play(arg_list[0], Coordinate.new(arg_list[1], arg_list[2]))
      end

      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
      end

      @game_state( @game_factory.player_token_generator( player ).get_token, row, column );
    end

    game_main.win_event.listen{ |winner|  puts "player number #{winner} has won" }
    game_main.exit_event.listen{ @running = false }
    game_state.on_change.listen{ puts game_state.to_s }

    run_cmds
  end

  def run_cmds
    while @running
      input = gets
      @cmd_parser.parse(input)
    end
  end
end