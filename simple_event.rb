class SimpleEvent
  def initialize
    @event_blocks = Array.new
  end

  def listen(&block)
    @event_blocks.push(block)
  end

  def fire(*args)
    @event_blocks.each { |block| block.call(*args) }
  end

end