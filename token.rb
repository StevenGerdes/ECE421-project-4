require './contract_exceptions'

class Token

  attr_accessor color, selected?
  attr_reader value
  def initialize(value)
    @value = value
  end

end

