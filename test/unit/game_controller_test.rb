require 'minitest/autorun'
require_relative '../../lib/game_controller.rb'

class GameControllerTest < Minitest::Test

  def test_that_GameSettings_is_instantiated_when_get_settings_is_called
    game_controller = GameController.new
    assert_instance_of(GameSettings, game_controller.get_settings)
  end

  def test_that_Display_is_instantiated_when_get_display_is_called
    game_controller = GameController.new
    assert_instance_of(Display, game_controller.get_display(game_controller.get_settings))
  end


end