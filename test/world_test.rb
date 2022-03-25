require 'minitest/autorun'
require './lib/world.rb'

class World_Test < MiniTest::Test

  def setup
    @fertile_setup = [
      ["o","x","o","o","o"],
      ["o","x","x","o","o"],
      ["o","x","o","o","o"],
      ["o","o","o","o","o"],
      ["o","o","o","o","o"]
    ]
  end

  def test_that_a_new_world_is_the_correct_size
    world = World.new(5,5)
    assert_equal(world.cells.flatten.length, (5 * 5))
  end


  def test_that_you_can_select_a_certain_cell
    world = World.new(5,5)
    cell = world.get_cell(1,1)
    assert_equal(cell, world.cells[1][1])
  end

  
  def test_that_you_can_make_a_dead_cell_alive
    world = World.new(5,5)
    world.set_alive_at(1,1)
    assert_equal(world.cells[1][1], "x")
  end

  def test_that_you_can_make_an_alive_cell_dead
    world = World.new(5,5)
    world.cells[1][1] = "x"
    world.set_dead_at(1,1)
    assert_equal(world.cells[1][1], "o")
  end

  def test_a_cell_has_8_neighbors
    world = World.new(5,5)
    neighbors = world.neighbors_of(1,1)
    assert_equal(neighbors.length, 8)
  end

  def test_an_alive_cell_will_be_dead_in_the_next_generation_if_underpopulated
    world = World.new(5,5)
    world.cells[1][1] = "x"
    status = world.alive_next_generation?(1,1)
    assert(status == false)
  end

  def test_an_alive_cell_will_be_dead_in_the_next_generation_if_overpopulated
    world = World.new(5,5)
    world.cells[1][1] = "x"
    world.cells[1][0] = "x"
    world.cells[1][2] = "x"
    world.cells[2][0] = "x"
    world.cells[2][1] = "x"
    assert_equal(world.alive_next_generation?(1,1), false)
  end

  def test_an_alive_cell_will_be_alive_in_the_next_generation_if_on_fertile_land
    world = World.new(5,5)
    world.cells[1][1] = "x"
    world.cells[1][0] = "x"
    world.cells[1][2] = "x"
    world.cells[2][0] = "x"
    assert_equal(world.alive_next_generation?(1,1), true)
  end

  def test_a_dead_cell_will_be_alive_in_the_next_generation_from_revival
    world = World.new(5,5)
    world.cells[1][0] = "x"
    world.cells[1][2] = "x"
    world.cells[2][0] = "x"
    assert_equal(world.revive_at?(1,1), true)
  end

  def test_a_dead_cell_will_stay_dead_in_the_next_generation_without_3_alive_neighbors
    world = World.new(5,5)
    world.cells[1][0] = "x"
    world.cells[2][0] = "x"
    assert_equal(world.revive_at?(1,1), false)
  end

  def test_that_a_fertile_setup_will_return_the_same_world_after_a_tick
    skip
    world = World.new(5,5).cells
    world = @fertile_setup
    assert_equal(world.tick, @fertile_setup)
  end

  def test_neighor_of_cell_on_left_edge_is_the_cell_on_the_same_row_on_the_right_edge
    world = World.new(5, 5)

    # refute_includes(world.neighbors_of(0, 4), nil)
    assert_equal(world.neighbors_of(1, 0)[5], world.cells[1][4])
  end

  def test_neighbor_of_cell_on_the_right_edge_is_on_the_same_row_on_the_left_edge
    world = World.new(5, 5)

    # refute_includes(world.neighbors_of(0, 4), nil)
    assert_equal(world.neighbors_of(1, 4)[5], world.cells[1][0])
  end

  def test_neighbor_of_cell_on_the_bottom_edge_is_on_the_same_column_on_the_top_edge
    world = World.new(5, 5)
    assert_equal(world.neighbors_of(4, 0)[0], world.cells[0][0])
  end

end