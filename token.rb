require './contract'

class Token
  include Contract

  attr_accessor :color, :selected?
  attr_reader :value

  class_invariant([])

  method_contract(
      #preconditions
      [lambda { |obj, value| value.respond_to?(:to_s) }],
      #postconditions
      [])

  def initialize(value)
    @value = value.to_s
  end

  def to_s
    @value.to_s
  end

end

