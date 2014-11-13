module ContractExceptions
  class PreconditionError < StandardError ; end
  class PostconditionError < StandardError ; end
  class InvarientError < StandardError ; end
end