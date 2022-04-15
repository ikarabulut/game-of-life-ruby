require_relative 'game_controller'

class Game
  
  def start_game
    game = GameController.new

    settings = game.get_settings
    settings.settings_prompt

    display = game.get_display(settings)

    world = game.create_world(display)
    world.generate_random_cells
    world.begin_evolutions
  end

end
