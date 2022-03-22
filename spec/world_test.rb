require 'minitest/autorun'
require_relative '../lib/world.rb'
require_relative '../lib/cell.rb'


class World_Test < MiniTest::Test

  def setup
    @columns = rand(5..10)
    @rows = rand(5..10)
  end

  def test_a_new_world_is_the_proper_size
    world = World.new(@columns, @rows).cells
    world = world.flatten
    assert_equal(world.length, (@columns * @rows) )
  end

  def test_a_checked_cell_is_the_correct_cell
    world = World.new(@columns, @rows)
    cell = world.get_cell(2,2)
    assert_equal(cell, world.cells[2][2])
  end

  

end

