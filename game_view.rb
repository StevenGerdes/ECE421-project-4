require 'gtk2'
require './game_main'

class GameView

  def initialize#(game, game_state)
      Gtk.init

      @builder = Gtk::Builder::new
      @builder.add_from_file('game_view.glade')
      @builder.connect_signals { |handler| method(handler) } # (No handlers yet, but I will have eventually)

      window = @builder.get_object('mainWindow')
      window.signal_connect('destroy') { Gtk.main_quit }

      menu = @builder.get_object('menuQuit')
      menu.signal_connect('activate') { Gtk.main_quit }

      menu = @builder.get_object('menuNew')
      menu.signal_connect('activate') {}

#      game
#      game_state.on_change.listen{
#        update_ui(game_state)
#      }

 #     (0..6).each { |col|
 #       @builder.get_object("play_#{col}").signal_connect('clicked') {
 #         game.play(col)
 #       }
 #     }

  #    game.start( 1, factory)

      window.show()
      Gtk.main()

    end

    def update_ui( game_state )

    end


end
