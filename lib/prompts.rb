class Prompts
  #TODO:: UPDATE TO JUST SAY SETTINGS
  def initialize(game_settings)
    @game_settings = game_settings
  end

  def print_messages
    puts display_welcome_message + display_defaults_message + display_defaults_prompt
  end

  def print_updated_settings
    puts display_updated_settings
  end

  private

  def display_welcome_message
    "Welcome to Conways Game of Life!"
  end

  def display_defaults_message
    "The defaults for this game are: \n" +
    "Alive cell: #{@game_settings[:alive_symbol]} \n" +
    "Dead cell: #{@game_settings[:dead_symbol]} \n" +
    "Grid Size: #{@game_settings[:rows]} X #{@game_settings[:columns]} \n" +
    "Evolutions: #{@game_settings[:evolutions]}"
  end

  # TODO:: THIS DOESNT UPDATE TO THE NEW SETTINGS
  # def display_updated_settings 
  #   "Your updated game settings are: \n" +
  #   "Alive cell: #{@game_settings[:alive_symbol]} \n" +
  #   "Dead cell: #{@game_settings[:dead_symbol]} \n" +
  #   "Grid Size: #{@game_settings[:rows]} X #{@game_settings[:columns]} \n" +
  #   "Evolutions: #{@game_settings[:evolutions]}"
  # end

  def display_defaults_prompt
    "Would you like to play with the defaults? (y/n)"
  end


end