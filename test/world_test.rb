require 'minitest/autorun'
require './lib/world.rb'
require './lib/cell.rb'

class World_Test < MiniTest::Test

  def setup
    @mock_blinker_world = World.new(5, 5)
    @mock_blinker_world.generate_dead_board
    @mock_blinker_world.cells[2][1].revive
    @mock_blinker_world.cells[2][2].revive
    @mock_blinker_world.cells[2][3].revive
  end

  def test_that_a_new_world_is_the_correct_size
    world = World.new(5, 5)
    assert_equal(25, world.cells.flatten.length)
  end

  def test_that_an_initially_generated_world_is_all_nil
    world = World.new(5, 5)
    world.cells.each do |row|
      row.each do |cell|
        assert_nil(cell)
      end
    end
  end

  def test_that_you_can_generate_a_random_board_state
    world = World.new(5, 5)
    world.generate_random_board
    world.cells.each do |row|
      row.each do |cell|
        refute_nil(cell)
      end
    end
  end

  def test_that_you_can_set_a_cell_to_alive
    world = World.new(5, 5)
    world.generate_dead_board
    world.set_alive_at(1, 1)
    assert_equal(true, world.cells[1][1].alive?)
  end

  def test_that_a_dead_cell_on_a_fully_dead_board_is_set_to_alive_with_set_alive_at
    world = World.new(5, 5)
    world.generate_dead_board
    world.set_alive_at(1, 1)
    assert_equal(true, world.cells[1][1].alive?)
  end

  def test_a_cell_has_8_neighbors
    world = World.new(5, 5)
    world.generate_dead_board
    neighbors = world.neighbors_of(1, 1)
    assert_equal(neighbors.length, 8)
    refute_includes(neighbors, nil)
  end

  def test_neighbor_to_the_right_of_a_cell_on_the_right_edge_wraps_to_the_left
    world = World.new(5, 5)
    world.generate_random_board
    refute_includes(world.neighbors_of(0, 4), nil)
    assert_equal(world.cells[0][0], world.neighbors_of(0, 4)[1])
  end

  def test_neighbor_to_the_bottom_of_cell_on_the_bottom_of_the_world_will_wrap_to_the_top
    world = World.new(5, 5)
    world.generate_random_board
    refute_includes(world.neighbors_of(0, 4), nil)
    assert_equal(world.cells[0][1], world.neighbors_of(4, 1)[2])
  end

  def test_neighbor_to_the_bottom_right_of_cell_on_the_bottom_right_edge_will_wrap_to_the_top_left_edge
    world = World.new(5, 5)
    world.generate_random_board
    refute_includes(world.neighbors_of(4, 4), nil)
    assert_equal(world.cells[0][0], world.neighbors_of(4, 4)[3])
  end

  def test_alive_neighbors_of_will_only_return_alive_neighbors
    world = World.new(5, 5)
    world.generate_random_board
    alive_neighbors = world.alive_neighbors_of(1, 1)
    alive_neighbors.each do |neighbor|
      assert_equal(true, neighbor.alive?)
    end
  end


  def test_an_alive_cell_will_be_dead_in_the_next_generation_if_underpopulated
    world = World.new(5, 5)
    world.generate_dead_board
    world.cells[0][0].revive
    assert_equal(false, world.alive_next_generation?(0, 0))
  end

  def test_an_alive_cell_will_be_dead_in_the_next_generation_if_overpopulated
    world = World.new(5, 5)
    world.generate_dead_board
    world.cells[1][3].revive
    world.cells[1][1].revive
    world.cells[1][2].revive
    world.cells[0][2].revive
    world.cells[2][2].revive
    refute(world.alive_next_generation?(1, 2))
  end

  def test_an_alive_cell_will_be_alive_in_the_next_generation_if_on_fertile_land
    world = World.new(5, 5)
    world.generate_dead_board
    world.cells[1][3].revive
    world.cells[1][2].revive
    world.cells[1][1].revive
    world.cells[2][2].revive
    assert_equal(true, world.alive_next_generation?(1, 2))
  end

  def test_a_dead_cell_will_be_alive_in_the_next_generation_from_revival
    world = World.new(5, 5)
    world.generate_dead_board
    world.cells[1][3].revive
    world.cells[1][1].revive
    world.cells[2][2].revive
    assert_equal(true, world.revive_at?(1, 2))
  end

  def test_a_dead_cell_will_stay_dead_in_the_next_generation_without_3_alive_neighbors
    world = World.new(5, 5)
    world.generate_dead_board
    world.cells[1][3].revive
    world.cells[1][1].revive
    assert_equal(false, world.revive_at?(1, 2))
  end

  def test_a_board_can_be_displayed_with_the_cells_1_or_0_status
    world = World.new(5, 5)
    world.generate_random_board
    new_board = world.display_board.flatten
    new_board.each do |status|
      if status == 0 || status == 1
        assert(true)
      else
        assert_equal(true, false, "#display_board did not return all 1's or 0's")
      end
    end
  end

  def test_a_new_world_creates_a_proper_new_world_when_tick_is_initiated
    world = World.new(5, 5)
    world.generate_dead_board
    world.cells[1][2].revive
    world.cells[2][2].revive
    world.cells[3][2].revive
    world.tick
    assert_equal(@mock_blinker_world.display_board, world.display_board)
  end

end