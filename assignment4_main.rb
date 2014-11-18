require './contract'

class Adder
  include Contract

  attr_accessor :varbb

  method_contract(
      #preconditions
      [lambda { |obj, a, b| a.respond_to?(:to_i) },
       lambda { |obj, a, b| b.respond_to?(:to_i) }],
      #postconditions
      [lambda { |obj, result, a, b| result == a.to_i + b.to_i}])
  def do_stuff(a, b)
    a.to_i + b.to_i
  end

  method_contract(
      [lambda {|obj, str| str.is_a? String}],
      []
  )
  def next_method( str)

  end

  def test_me
    @varbb = 0
  end


end

a = Adder.new
puts a.do_stuff(10, 'a')
a.next_method('1')