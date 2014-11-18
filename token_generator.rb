require './contract'

class TokenGenerator
  include Contract

  class_invariant([])

  method_contract(
      #preconditions
      [lambda { |obj, result| result.respond_to?(:color) },
       lambda { |obj, result| result.respond_to?(:selected?) },
       lambda { |obj, result| result.respond_to?(:value) }],
      #postconditions
      [])

  def get_token
    token = nil
  end

end