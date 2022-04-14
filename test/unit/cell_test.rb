require "minitest/autorun"
require_relative "../../lib/cell.rb"

class CellTest < Minitest::Test


  def test_that_a_cell_that_is_alive_returns_true
    cell = Cell.new(1, 1, true)
    assert(cell.alive?)
  end

  def test_that_a_dead_cell_can_be_revived
    cell = Cell.new(1, 1, false)
    cell.revive
    assert(cell.alive?)
  end

  def test_that_an_alive_cell_can_die
    cell = Cell.new(1, 1, true)
    cell.die
    refute(cell.alive?)
  end


end