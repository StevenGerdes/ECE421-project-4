require './contract_exceptions'

class Token

  attr_accessor :color, :selected?
  attr_reader :value
  def initialize(value)
    #precondition
    unless value.respond_to? (:to_s)
      raise PreconditionError
    end
    @value = value
  end

  def to_s
    @value.to_s
  end

end

