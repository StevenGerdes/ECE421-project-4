class SimpleEvent

  @event_blocks = Array.new

  def listen(&block)
    @event_blocks.add(block)
  end

  def fire(*args)
    @event_blocks.each{ |block| block.call( *args )  }
  end

end