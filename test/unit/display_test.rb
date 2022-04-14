require 'minitest/autorun'
require_relative "../../lib/display.rb"

class DisplayTest < MiniTest::Test

  def test_that_a_5x5_board_is_generated_with_game_settings_of_5x5
    game_settings = FakeGameSettings.new
    display = Display.new(game_settings)
    display.generate_board
    expected = [
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil]
    ]
    assert_equal(expected, display.board)
  end



end

class FakeGameSettings
  attr_reader :rows, :columns, :alive_symbol, :dead_symbol

  def initialize
    @rows = 5
    @columns = 5
    @alive_symbol = 1
    @dead_symbol = 0
  end

end