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
  
    def set_grid_size
      25
    end
  
    def set_iterations_number
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



end