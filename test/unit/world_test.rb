require 'minitest/autorun'
require_relative '../../lib/world.rb'

class WorldTest < MiniTest::Test

  def setup
    system_interaction_mock = MiniTest::Mock.new
    @mock_blinker_world = World.new(FakeDisplay.new,system_interaction_mock )
    @mock_blinker_world.generate_dead_cells
    @mock_blinker_world.cells[2][1].revive
    @mock_blinker_world.cells[2][2].revive
    @mock_blinker_world.cells[2][3].revive
  end

  def display_board(cells)
    cells.flatten.map do |cell|
      cell.alive? ? 1 : 0
    end
  end

  def test_that_generate_dead_cells_fills_the_board_with_all_dead_cells
    system_interaction_mock = MiniTest::Mock.new
    world = World.new(FakeDisplay.new, system_interaction_mock)
    world.generate_dead_cells
    refute(nil, world.cells)
    world.cells.flatten.each { |cell| refute(cell.alive?) }
  end

  def test_that_generate_random_cells_fills_the_board_with_dead_and_alive_cells
    system_interaction_mock = MiniTest::Mock.new
    world = World.new(FakeDisplay.new, system_interaction_mock)
    world.generate_random_cells
    refute(nil, world.cells)
    world.cells.flatten.each { |cell| assert(cell.alive? || !cell.alive?) }
  end

  def test_a_vertical_blicker_will_return_a_horizontal_blinker_when_tick_is_initiated
    system_interaction_mock = MiniTest::Mock.new
    world = World.new(FakeDisplay.new, system_interaction_mock)
    world.generate_dead_cells
    world.cells[1][2].revive
    world.cells[2][2].revive
    world.cells[3][2].revive
    world.tick
    assert_equal(display_board(@mock_blinker_world.cells), display_board(world.cells))
  end

  class DisplaySingleEvolution < MiniTest::Test

    def test_it_clears_the_screen
      system_interaction_mock = MiniTest::Mock.new
      fake_display = FakeDisplay.new
      world = World.new(fake_display, system_interaction_mock)

      system_interaction_mock.expect :clear, nil
      
      world.display_single_evolution
      system_interaction_mock.verify
    end
    

  end

  class NeighborsTestSuite < MiniTest::Test

    def test_a_cell_has_8_neighbors
      system_interaction_mock = MiniTest::Mock.new
      world = World.new(FakeDisplay.new, system_interaction_mock)
      world.generate_dead_cells
      neighbors = world.neighbors_of(1, 1)
      assert_equal(neighbors.length, 8)
      refute_includes(neighbors, nil)
    end

    def test_neighbor_to_the_right_of_a_cell_on_the_right_edge_wraps_to_the_left
      system_interaction_mock = MiniTest::Mock.new
      world = World.new(FakeDisplay.new, system_interaction_mock)
      world.generate_random_cells
      refute_includes(world.neighbors_of(0, 4), nil)
      assert_equal(world.cells[0][0], world.neighbors_of(0, 9)[1])
    end

    def test_neighbor_to_the_bottom_of_cell_on_the_bottom_of_the_world_will_wrap_to_the_top
      system_interaction_mock = MiniTest::Mock.new
      world = World.new(FakeDisplay.new, system_interaction_mock)
      world.generate_random_cells
      refute_includes(world.neighbors_of(0, 4), nil)
      assert_equal(world.cells[0][1], world.neighbors_of(9, 1)[2])
    end

    def test_neighbor_to_the_bottom_right_of_cell_on_the_bottom_right_edge_will_wrap_to_the_top_left_edge
      system_interaction_mock = MiniTest::Mock.new
      world = World.new(FakeDisplay.new, system_interaction_mock)
      world.generate_random_cells
      refute_includes(world.neighbors_of(4, 4), nil)
      assert_equal(world.cells[0][0], world.neighbors_of(9, 9)[3])
    end

    def test_alive_neighbors_of_will_only_return_alive_neighbors
      system_interaction_mock = MiniTest::Mock.new
      world = World.new(FakeDisplay.new, system_interaction_mock)
      world.generate_random_cells
      alive_neighbors = world.alive_neighbors_of(1, 1)
      alive_neighbors.each do |neighbor|
        assert_equal(true, neighbor.alive?)
      end
    end
  
  end

  class RulesTestSuite < MiniTest::Test

    def test_that_an_alive_cell_with_2_alive_neighbors_stays_alive
      system_interaction_mock = MiniTest::Mock.new
      world = World.new(FakeDisplay.new, system_interaction_mock)
      world.generate_dead_cells
      world.cells[2][5].revive
      world.cells[2][6].revive
      world.cells[3][5].revive
      assert(world.alive_next_generation?(2, 5))
    end

    def test_that_an_alive_cell_with_3_alive_neighbors_stays_alive
      system_interaction_mock = MiniTest::Mock.new
      world = World.new(FakeDisplay.new, system_interaction_mock)
      world.generate_dead_cells
      world.cells[1][5].revive
      world.cells[2][4].revive
      world.cells[2][5].revive
      world.cells[2][6].revive
      world.cells[3][5].revive
      assert(world.alive_next_generation?(1, 5), "An alive cell with 3 alive neighbors did survive an evolution")
    end

    def test_that_an_alive_cell_with_more_than_3_alive_neighbors_does_not_survive
      system_interaction_mock = MiniTest::Mock.new
      world = World.new(FakeDisplay.new, system_interaction_mock)
      world.generate_dead_cells
      world.cells[1][5].revive
      world.cells[2][4].revive
      world.cells[2][5].revive
      world.cells[2][6].revive
      world.cells[3][5].revive
      refute(world.alive_next_generation?(2, 5), "An alive cell with more than 3 alive neighbors survived when it should have died")
    end

    def test_that_an_alive_cell_with_less_than_2_alive_neighbors_does_not_survive
      system_interaction_mock = MiniTest::Mock.new
      world = World.new(FakeDisplay.new, system_interaction_mock)
      world.generate_dead_cells
      world.cells[2][5].revive
      refute(world.alive_next_generation?(2, 5), "An alive cell with less than 2 alive neighbors survived when it should have died")
    end

    def test_that_a_dead_cell_with_exactly_3_alive_neighbors_will_come_to_life
      system_interaction_mock = MiniTest::Mock.new
      world = World.new(FakeDisplay.new, system_interaction_mock)
      world.generate_dead_cells
      world.cells[2][5].revive
      world.cells[2][6].revive
      world.cells[3][5].revive
      assert(world.alive_next_generation?(3, 6), "A dead cell with exactly 3 alive neighbors stayed dead when it should have revived")
    end

    def test_that_a_dead_cell_without_exactly_3_alive_neighbors_stays_dead
      system_interaction_mock = MiniTest::Mock.new
      world = World.new(FakeDisplay.new, system_interaction_mock)
      world.generate_dead_cells
      world.cells[2][5].revive
      world.cells[2][6].revive
      refute(world.alive_next_generation?(3, 6), "A dead cell without exactly 3 alive neighbors revived when it should have stayed dead")
    end

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