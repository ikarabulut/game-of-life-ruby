require 'minitest/autorun'
require './lib/world.rb'
require './lib/cell.rb'

class World_Test < MiniTest::Test

  def test_that_a_new_world_is_the_correct_size
    world = World.new(5, 5)
    assert_equal(world.cells.flatten.length, (5 * 5))
  end

  def test_that_an_initially_generated_world_is_all_dead_cells
    world = World.new(5, 5)
    assert(world.empty?)
  end

  
  def test_that_you_can_generate_a_random_board_state
    world = World.new(5, 5)
    world.generate_random_cells
    refute_includes(world.cells, nil)
  end

  def test_that_you_can_set_a_cell_to_alive
    world = World.new(5, 5)
    mock_cell = world.set_alive_at(1, 1)
    assert_equal(mock_cell.status, "alive")
  end

  def test_that_a_world_is_no_longer_empty_after_adding_an_alive_cell
    world = World.new(5, 5)
    world.set_alive_at(1, 1)
    refute(world.empty?)
  end

  def test_a_cell_has_8_neighbors
    world = World.new(5, 5)
    world.generate_dead_board
    neighbors = world.neighbors_of(1, 1)
    assert_equal(neighbors.length, 8)
    refute_includes(neighbors, nil)
  end

  # def test_an_alive_cell_will_be_dead_in_the_next_generation_if_underpopulated
  #   world = World.new(5, 5)
  #   alive_neighbors_of(0, 0)

  #   status = world.alive_next_generation?(0, 0)
  #   assert(status == false)
  # end

  # def test_an_alive_cell_will_be_dead_in_the_next_generation_if_overpopulated
  #   world = World.new(5, 5)
  #   world.cells = @still_life
  #   world.cells[3][2] = "x"
  #   assert_equal(world.alive_next_generation?(2, 2), false)
  # end

  # def test_an_alive_cell_will_be_alive_in_the_next_generation_if_on_fertile_land
  #   world = World.new(5, 5)
  #   world.cells = @still_life
  #   assert_equal(world.alive_next_generation?(1, 2), true)
  # end

  # def test_a_dead_cell_will_be_alive_in_the_next_generation_from_revival
  #   world = World.new(5, 5)
  #   world.cells = @still_life
  #   world.cells[3][2] = "x"
  #   assert_equal(world.revive_at?(3, 3), true)
  # end

  # def test_a_dead_cell_will_stay_dead_in_the_next_generation_without_3_alive_neighbors
  #   world = World.new(5, 5)
  #   world.cells = @still_life
  #   assert_equal(world.revive_at?(0, 2), false)
  # end

  # def test_neighbor_of_a_cell_on_the_right_edge_wraps_to_the_left
  #   world = World.new(5, 5)

  #   refute_includes(world.neighbors_of(0, 4), nil)
  #   assert_equal(world.neighbors_of(0, 4)[1], world.cells[0][0])
  # end

  # def test_neighbor_of_cell_on_the_bottom_of_the_world_will_wrap_to_the_top
  #   world = World.new(5, 5)

  #   refute_includes(world.neighbors_of(0, 4), nil)
  #   assert_equal(world.neighbors_of(4, 1)[2], world.cells[0][1])
  # end

  # def test_neighbor_of_cell_on_the_bottom_right_edge_will_wrap_to_the_top_right_edge
  #   world = World.new(5, 5)
  #   refute_includes(world.neighbors_of(4, 4), nil)
  # end

end