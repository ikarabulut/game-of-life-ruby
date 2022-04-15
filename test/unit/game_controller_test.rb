require 'minitest/autorun'
require_relative '../../lib/game_controller.rb'

class GameControllerTest < Minitest::Test

  def test_that_GameSettings_is_instantiated
    game_controller = GameController.new
    assert_instance_of(GameSettings, game_controller.get_settings)
  end




end