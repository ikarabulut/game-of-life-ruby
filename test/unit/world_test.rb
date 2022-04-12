require 'minitest/autorun'
require_relative '../../lib/world.rb'

class WorldTest < MiniTest::Test

  def test_that_an_alive_cell_with_2_alive_neighbors_stays_alive
    world = World.new(FakeDisplay.new)
    world.generate_dead_cells
    world.cells[2][5].revive
    world.cells[2][6].revive
    world.cells[3][5].revive
    assert(world.alive_next_generation?(2, 5))
  end

  def test_that_an_alive_cell_with_3_alive_neighbors_stays_alive
    world = World.new(FakeDisplay.new)
    world.generate_dead_cells
    world.cells[1][5].revive
    world.cells[2][4].revive
    world.cells[2][5].revive
    world.cells[2][6].revive
    world.cells[3][5].revive
    assert(world.alive_next_generation?(1, 5), "An alive cell with 3 alive neighbors did survive an evolution")
  end

  def test_that_an_alive_cell_with_more_than_3_alive_neighbors_does_not_survive
    world = World.new(FakeDisplay.new)
    world.generate_dead_cells
    world.cells[1][5].revive
    world.cells[2][4].revive
    world.cells[2][5].revive
    world.cells[2][6].revive
    world.cells[3][5].revive
    refute(world.alive_next_generation?(2, 5), "An alive cell with more than 3 alive neighbors survived when it should have died")
  end

  def test_that_an_alive_cell_with_less_than_2_alive_neighbors_does_not_survive
    world = World.new(FakeDisplay.new)
    world.generate_dead_cells
    world.cells[2][5].revive
    refute(world.alive_next_generation?(2, 5), "An alive cell with less than 2 alive neighbors survived when it should have died")
  end

  def test_that_a_dead_cell_with_exactly_3_alive_neighbors_will_come_to_life
    world = World.new(FakeDisplay.new)
    world.generate_dead_cells
    world.cells[2][5].revive
    world.cells[2][6].revive
    world.cells[3][5].revive
    assert(world.alive_next_generation?(3, 6), "A dead cell with exactly 3 alive neighbors stayed dead when it should have revived")
  end

  def test_that_a_dead_cell_without_exactly_3_alive_neighbors_stays_dead
    world = World.new(FakeDisplay.new)
    world.generate_dead_cells
    world.cells[2][5].revive
    world.cells[2][6].revive
    refute(world.alive_next_generation?(3, 6), "A dead cell without exactly 3 alive neighbors revived when it should have stayed dead")
  end

end

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