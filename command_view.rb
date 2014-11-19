require 'optparse'
class CommandView


  def initialize(game_factory)
    @running = true
    @game_factory = game_factory
    @game_main = game_factory.connect_game
    @game_state = game_factory.game_state

    @cmd_parser = OptionParser.new do |opts|
      opts.on('-d', '--display', 'display the game board') do
        puts @game_state.to_s
      end

      opts.on('-c', Integer, 'display current player') do
        puts @game_state.player_turn.to_s
      end

      opts.on('-p number,row,column', '--play number,row,column', Array, 'Play token for player at coordinates') do |arg_list|
        if arg_list.length == 1
          @game_main.play(arg_list[0])
        else
          @game_state.play(@game_factory.player_token_generator(arg_list[0]).get_token, Coordinate.new(arg_list[1], arg_list[2]))
        end
      end

      opts.on('-e', '--exit', 'Exit Debug Console') do
        @running = false
      end

      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
      end

    end

    @game_main.on_win.listen { |winner| puts "player number #{winner} has won" }
    @game_main.on_quit.listen { @running = false }
    @game_state.on_change.listen { puts @game_state.to_s }
    start
  end

  def start
    while @running
      print '>'
      input = gets
      begin
        @cmd_parser.parse(input)
      rescue OptionParser::InvalidOption
      end
    end
  end
end