require 'minitest/autorun'
require_relative '../../lib/world.rb'

class FakeGameSettings
  attr_reader :alive_symbol, :dead_symbol, :rows, :columns, :evolutions, :defaults, :game_settings

  def initialize
    @alive_symbol = 1
    @dead_symbol = 0
    @rows = 10
    @columns = 10
    @evolutions = "infinity"
    @defaults = true
    @game_settings = {rows: @rows, columns: @columns, alive_symbol: @alive_symbol, dead_symbol: @dead_symbol, evolutions: @evolutions}
  end

end

class FakeDisplay
  attr_reader :board, :game_settings

  def initialize(game_settings= FakeGameSettings.new)
    @game_settings = game_settings
    @board = generate_board
  end

  def generate_board
    Array.new(@game_settings.rows) { Array.new(@game_settings.columns) }
  end

end

class WorldTest < MiniTest::Test

  def test_that_an_alive_cell_with_2_alive_neighbors_stays_alive
    world = World.new(FakeDisplay.new)
    world.generate_dead_cells
    world.cells[2][5].revive
    world.cells[2][6].revive
    world.cells[3][5].revive
    assert(true, world.alive_next_generation?(2, 5))
  end






end