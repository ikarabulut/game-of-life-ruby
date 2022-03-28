require 'minitest/autorun'
require './lib/world.rb'

class World_Test < MiniTest::Test

  def setup
    @still_life = [
      ["o","o","o","o","o"],
      ["o","o","x","x","o"],
      ["o","o","x","x","o"],
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
    world.cells = @still_life
    world.cells[0][0] = "x"
    status = world.alive_next_generation?(0, 0)
    assert(status == false)
  end

  def test_an_alive_cell_will_be_dead_in_the_next_generation_if_overpopulated
    world = World.new(5,5)
    world.cells = @still_life
    world.cells[3][2] = "x"
    assert_equal(world.alive_next_generation?(2, 2), false)
  end

  def test_an_alive_cell_will_be_alive_in_the_next_generation_if_on_fertile_land
    world = World.new(5,5)
    world.cells = @still_life
    assert_equal(world.alive_next_generation?(1,2), true)
  end

  def test_a_dead_cell_will_be_alive_in_the_next_generation_from_revival
    world = World.new(5,5)
    world.cells = @still_life
    world.cells[3][2] = "x"
    assert_equal(world.revive_at?(3,3), true)
  end

  def test_a_dead_cell_will_stay_dead_in_the_next_generation_without_3_alive_neighbors
    world = World.new(5,5)
    world.cells = @still_life
    assert_equal(world.revive_at?(0, 2), false)
  end

  # def test_that_a_still_life_will_stay_still_after_a_tick
  #   world = World.new(5, 5)
  #   world.cells = @still_life
  #   assert_equal(world.tick, @still_life)
  # end

  def test_neighbor_of_a_cell_on_the_right_edge_wraps_to_the_left
    world = World.new(5, 5)

    refute_includes(world.neighbors_of(0, 4), nil)
    assert_equal(world.neighbors_of(0, 4)[1], world.cells[0][0])
  end

  def test_neighbor_of_cell_on_the_bottom_of_the_world_will_wrap_to_the_top
    world = World.new(5, 5)

    refute_includes(world.neighbors_of(0, 4), nil)
    assert_equal(world.neighbors_of(4, 1)[2], world.cells[0][1])
  end

  def test_neighbor_of_cell_on_the_bottom_right_edge_will_wrap_to_the_top_right_edge
    world = World.new(5, 5)
    refute_includes(world.neighbors_of(4, 4), nil)
  end

end