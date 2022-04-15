require 'minitest/autorun'
require_relative '../../lib/world.rb'

class GenerateWorldTest < MiniTest::Test

  def test_generating_a_random_board
    input_getter = InputGetter.new
    game_settings = GameSettings.new(input_getter)
    display = Display.new(game_settings)
    world = World.new(display, SystemInteraction.new)

    world.generate_random_cells
    world.cells.flatten.each do |cell|
      refute_nil(cell)
    end
  end

end