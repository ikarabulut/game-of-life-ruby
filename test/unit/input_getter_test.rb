require 'minitest/autorun'
require_relative '../../lib/input_getter.rb'

class InputGetterTest < MiniTest::Test

  def test_that_you_can_set_your_alive_symbol_to_A
    input = StringIO.new("A")
    input_getter = InputGetter.new(input)
    alive_symbol = input_getter.get_alive_symbol
    assert_equal("A", alive_symbol)
  end

  def test_that_you_can_set_your_dead_symbol_to_D
    input = StringIO.new("D")
    input_getter = InputGetter.new(input)
    dead_symbol = input_getter.get_dead_symbol
    assert_equal("D", dead_symbol)
  end

  def test_that_you_can_set_the_number_of_rows_to_7
    input = StringIO.new("7")
    input_getter = InputGetter.new(input)
    rows = input_getter.get_number_of_rows
    assert_equal(7, rows)
  end

  def test_that_you_can_set_the_number_of_columns_to_7
    input = StringIO.new("7")
    input_getter = InputGetter.new(input)
    columns = input_getter.get_number_of_columns
    assert_equal(7, columns)
  end

  def test_that_you_can_set_the_number_of_evolutions_to_47
    input = StringIO.new("47")
    input_getter = InputGetter.new(input)
    evolutions = input_getter.get_number_of_evolutions
    assert_equal(47, evolutions)
  end

  def test_that_the_defaults_prompt_response_will_be_false_if_n_is_entered
    input = StringIO.new("n")
    input_getter = InputGetter.new(input)
    default_prompt = input_getter.get_defaults_prompt_response
    refute(default_prompt)
  end

  def test_that_the_defaults_prompt_response_will_be_true_if_y_is_entered
    input = StringIO.new("y")
    input_getter = InputGetter.new(input)
    default_prompt = input_getter.get_defaults_prompt_response
    assert(default_prompt)
  end

end