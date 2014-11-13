require './contract_exceptions'

class ConnectGameFactory

  def initialize

  end

  def player_token_generator(player_num)
    #precondition
    unless player_num.respond_to? :to_i &&
      player_num.to_i > 0
      raise PreconditionError
    end

    #invarient store


    result = nil

    #postcondition
    unless result.respond_to? :get_token
      raise PostconditionError
    end

    #invarient Check

  end

  def player_win_condition_checker(player_num)
    #precondition
    unless player_num.respond_to? :to_i &&
                                      player_num.to_i > 0
      raise PreconditionError
    end

    #invarient store


    result = nil

    #postcondition
    unless result.respond_to? :check_win
      raise PostconditionError
    end

    #invarient Check

  end

end