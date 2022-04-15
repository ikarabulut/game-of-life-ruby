require_relative 'game_settings'
require_relative 'world'
require_relative 'display'
require_relative 'cell'

class GameController
  attr_reader :input_getter

  def initialize
    @input_getter = InputGetter.new
  end

  def get_settings
    GameSettings.new(@input_getter)
  end

  def get_display(settings)
    Display.new(settings)
  end

  def create_world(display)
    World.new(display, SystemInteraction.new)
  end


end