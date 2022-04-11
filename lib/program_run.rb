require_relative 'game_controller'

def start_game
  game = GameController.new

  settings = game.get_settings
  settings.settings_prompt

  board = game.get_board(settings)

  world = game.create_world(board)
  world.generate_random_cells
  p world.cells
end

start_game