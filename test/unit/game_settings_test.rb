require 'minitest/autorun'
require_relative "../../lib/game_settings.rb"

class GameSettingsTest < MiniTest::Test

  def test_that_the_alive_symbol_is_updated_when_set
    fake_input_getter = FakeInputGetter.new
    game_settings = GameSettings.new(fake_input_getter)
    game_settings.set_alive_symbol
    assert_equal("o", game_settings.alive_symbol)
  end





end

class FakeInputGetter
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

  def get_number_of_evolutions
    40
  end
end