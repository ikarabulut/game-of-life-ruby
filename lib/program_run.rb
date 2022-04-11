require_relative 'game_controller'

def start_game
  game = GameController.new
  game.start
end

start_game