module Contract
  class PreconditionError < StandardError;
  end
  class PostconditionError < StandardError;
  end
  class InvariantError < StandardError;
  end
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods


    def method_contract(preconditions, postconditions)
      @last_pre = preconditions
      @last_post = postconditions
    end

    def method_added method
      name_change = '_contract_wrapped_method'
      return if method.to_s.include?( name_change) ||
          method.equal?(@last_method) ||
          @last_pre.nil? || @last_post.nil?


      @last_method = method
      preconditions = @last_pre
      @last_pre = nil
      postconditions = @last_post
      @last_post = nil
      alias_method "#{method}#{name_change}", method
      define_method method do |*args|
        preconditions.each_with_index { |block, index|
          unless block.call(self, *args)
            puts "precondition #{index} failed for method #{method}"
            raise PreconditionError
          end
        }
        result = send "#{method}#{name_change}", *args
        postconditions.each_with_index { |block, index|
          unless block.call(self, result, *args)
            puts "postcondition #{index} failed for method #{method}"
            raise PostconditionError
          end
        }
        result
      end
    end
  end
end