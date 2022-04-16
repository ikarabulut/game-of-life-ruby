require 'minitest/autorun'
require_relative "../../lib/display.rb"

class DisplayTest < MiniTest::Test

  def test_that_a_5x5_board_is_generated_with_game_settings_of_5x5
    rows_mock = 5
    columns_mock = 5
    game_settings = FakeGameSettings.new(rows_mock, columns_mock)
    display = Display.new(game_settings)
    display.generate_board
    expected = [[nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil] ]
    assert_equal(expected, display.board)
  end

  def test_that_print_board_will_print_the_board_to_the_terminal
    rows_mock = 1
    columns_mock = 1
    fake_game_settings = FakeGameSettings.new(rows_mock, columns_mock)
    display = Display.new(fake_game_settings)
    fake_world_generation = Array.new(display.game_settings.rows) { Array.new(display.game_settings.columns) { Cell.new(0, 0, false) } }
    expected =  <<~BOARD
    \n
     0 
    BOARD
    assert_output(expected) { display.print_board(fake_world_generation) }
  end

end

class FakeGameSettings
  attr_reader :rows, :columns, :alive_symbol, :dead_symbol

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @alive_symbol = 1
    @dead_symbol = 0
  end

end

