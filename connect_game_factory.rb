require './contract_exceptions'

class ConnectGameFactory

  def initialize( players, type )
    @player_count = players
  end

  def player_token_generator(player_num)
    #precondition
    unless player_num.respond_to? :to_i && player_num.to_i > 0
      raise PreconditionError
    end

    result = nil

    #postcondition
    unless result.respond_to? :get_token
      raise PostconditionError
    end
  end

  def player_win_condition_checker(player_num)
    #precondition
    unless player_num.respond_to?(:to_i) && player_num.to_i > 0
      raise PreconditionError
    end

    result = nil

    #postcondition
    unless result.respond_to? :check_win
      raise PostconditionError
    end
  end

  def player_win_condition_checkers
    (0..@player_count).map { |player| player_win_condition_checker(player) }
  end

end