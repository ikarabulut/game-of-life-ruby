require 'minitest/autorun'
require_relative '../lib/ui.rb'

class UI_Test < Minitest::Test

  class StubInputGetter
    def get_alive_symbol
     "o"
    end
  
    def get_dead_symbol
      "x"
    end
  
    def get_number_of_rows
      10
    end

    def get_number_of_columns
      25
    end
  
    def get_iterations_number
      40
    end
  end

  def test_user_can_set_alive_cell_symbol
    ui = UI.new(StubInputGetter.new)
    ui.set_alive_symbol
    assert_equal(ui.alive_symbol, "o")
  end

  def test_user_can_set_dead_cell_symbol
    ui = UI.new(StubInputGetter.new)
    ui.set_dead_symbol
    assert_equal(ui.dead_symbol, "x")
  end

  def test_default_symbols_are_1_and_0
    ui = UI.new
    assert_equal(1, ui.alive_symbol)
    assert_equal(0, ui.dead_symbol)
  end

  def test_user_can_select_the_number_of_rows
    ui = UI.new(StubInputGetter.new)
    ui.set_number_of_rows
    assert_equal(10, ui.rows)
  end

  def test_user_can_select_the_number_of_columns
    ui = UI.new(StubInputGetter.new)
    ui.set_number_of_columns
    assert_equal(25, ui.columns)
  end

  def test_the_default_number_of_rows_and_columns_is_10_and_10
    ui = UI.new
    assert_equal(10, ui.rows)
    assert_equal(10, ui.columns)
  end



end