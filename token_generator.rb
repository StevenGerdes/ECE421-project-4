require './contract_exceptions'

class TokenGenerator

  def get_token
    #precondition - none
    #invarient - none

    token = nil

    #postcondition
    unless
        token.respond_to?( :color )  &&
        token.respond_to?( :selected? ) &&
        token.respond_to?( :value )
      raise PostconditionError
    end

  end

end