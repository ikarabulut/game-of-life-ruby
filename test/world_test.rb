require 'minitest/autorun'
require './lib/world.rb'
require './lib/cell.rb'

class World_Test < MiniTest::Test

  def test_that_a_new_world_is_the_correct_size
    world = World.new(5, 5)
    assert_equal(25, world.cells.flatten.length)
  end

  def test_that_an_initially_generated_world_is_all_dead_cells
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
    mock_cell = world.set_alive_at(1, 1)
    assert_equal("alive", mock_cell.status)
  end

  def test_that_a_dead_cell_on_a_fully_dead_board_is_set_to_alive_with_set_alive_at
    world = World.new(5, 5)
    world.generate_dead_board
    world.set_alive_at(1, 1)
    assert_equal("alive", world.cells[1][1].status)
  end

  def test_a_cell_has_8_neighbors
    world = World.new(5, 5)
    world.generate_dead_board
    neighbors = world.neighbors_of(1, 1)
    assert_equal(neighbors.length, 8)
    refute_includes(neighbors, nil)
  end

  def test_alive_neighbors_of_will_only_return_alive_neighbors
    world = World.new(5, 5)
    world.generate_random_board
    alive_neighbors = world.alive_neighbors_of(1, 1)
    alive_neighbors.each do |neighbor|
      status = neighbor.status
      assert_equal("alive", status)
    end
  end


  def test_an_alive_cell_will_be_dead_in_the_next_generation_if_underpopulated
    world = World.new(5, 5)
    world.generate_dead_board
    world.cells[0][0].status = "alive"
    assert_equal(false, world.alive_next_generation?(0, 0))
  end

  def test_an_alive_cell_will_be_dead_in_the_next_generation_if_overpopulated
    world = World.new(5, 5)
    world.generate_dead_board
    world.cells[1][3].status = "alive"
    world.cells[1][1].status = "alive"
    world.cells[1][2].status = "alive"
    world.cells[0][2].status = "alive"
    world.cells[2][2].status = "alive"
    refute(world.alive_next_generation?(1, 2))
  end

  def test_an_alive_cell_will_be_alive_in_the_next_generation_if_on_fertile_land
    world = World.new(5, 5)
    world.generate_dead_board
    world.cells[1][3].status = "alive"
    world.cells[1][2].status = "alive"
    world.cells[1][1].status = "alive"
    world.cells[2][2].status = "alive"
    assert_equal(true, world.alive_next_generation?(1, 2))
  end

  def test_a_dead_cell_will_be_alive_in_the_next_generation_from_revival
    world = World.new(5, 5)
    world.generate_dead_board
    world.cells[1][3].status = "alive"
    world.cells[1][1].status = "alive"
    world.cells[2][2].status = "alive"
    assert_equal(true, world.revive_at?(1, 2))
  end

  def test_a_dead_cell_will_stay_dead_in_the_next_generation_without_3_alive_neighbors
    world = World.new(5, 5)
    world.generate_dead_board
    world.cells[1][3].status = "alive"
    world.cells[1][1].status = "alive"
    assert_equal(false, world.revive_at?(1, 2))
  end

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