require 'optparse'
class CommandView


  def initialize( game_factory, game_main, game_state)
    @running = true
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
        @game_state.play(@game_factory.player_token_generator(arg_list[0]).get_token, Coordinate.new(arg_list[1], arg_list[2]))
      end

      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
      end

    end

    game_main.on_win.listen{ |winner|  puts "player number #{winner} has won" }
    game_main.on_quit.listen{ @running = false }
    game_state.on_change.listen{ puts game_state.to_s }

  end

  def start
    while @running
      input = gets
      @cmd_parser.parse(input)
    end
  end
end