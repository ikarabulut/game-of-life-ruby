require 'minitest/autorun'
require_relative '../lib/cell.rb'
require_relative '../lib/world.rb'


class Cell_Test < MiniTest::Test

  def setup
    @columns = rand(5..10)
    @rows = rand(5..10)
    @world = World.new(@columns, @rows)
  end

  def test_setup_is_working_properly
    assert_equal(@world.columns, @columns)
    assert_equal(@world.rows, @rows)
  end

  def test_generated_cells_are_full_of_dead_or_alive_cells_only
    cells = @world.cells
    cells.each do |x|
      x.each do |y|
        assert(y.status !=nil)
      end
    end
  end

  def test_a_cell_has_8_neighbors
    cell = @world.get_cell(3,3)
    assert_equal(cell.neighbors.length, 8)
  end



end