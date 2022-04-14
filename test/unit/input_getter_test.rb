require 'minitest/autorun'
require_relative '../../lib/input_getter.rb'

class InputGetterTest < MiniTest::Test

  def test_that_you_can_set_your_alive_symbol_to_A
    input = StringIO.new("A")
    input_getter = InputGetter.new(input)
    alive_symbol = input_getter.get_alive_symbol
    assert_equal("A", alive_symbol)
  end



end