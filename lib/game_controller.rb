require_relative 'game_settings'
require_relative 'world'
require_relative 'board'

class GameController

  def initialize
    @game_settings = GameSettings.new
    @board = Board.new(@game_settings)
    @world = World.new(@board)
  end

  def start
    @game_settings.settings_prompt
    @world.generate_random_cells
    @world.begin_evolutions
  end

end