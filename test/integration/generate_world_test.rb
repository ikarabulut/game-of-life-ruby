require 'minitest/autorun'
require_relative '../../lib/world.rb'

class GenerateWorldTest < MiniTest::Test

  def test_generating_a_random_board
    world = World.new
    world.generate_random_cells
    board = world.board
    board.flatten.each do |cell|
      refute_nil(cell)
    end
  end

end