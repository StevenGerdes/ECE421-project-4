require 'gtk2'

class ConnectFourView 

  def initialize( )
    if __FILE__ == $0
      Gtk.init

      @builder = Gtk::Builder::new
      @builder.add_from_file("connect4.glade")
      @builder.connect_signals{ |handler| method(handler) }  # (No handlers yet, but I will have eventually)

      window = @builder.get_object("mainWindow")
      window.signal_connect( "destroy" ) { Gtk.main_quit }
      
	  menu = @builder.get_object("menuQuit")
      menu.signal_connect( "activate" ) { Gtk.main_quit }
      
	  menu = @builder.get_object("menuNew")
      menu.signal_connect( "activate" ) { game_state.reset }
	  
	  game_state.on_win{ win_exit }
	  game_state.on_play

      window.show()
      Gtk.main()
	  
    end
  end

end
