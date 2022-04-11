require_relative 'input_getter'
require_relative 'prompts'

class GameSettings
  attr_reader :alive_symbol, :dead_symbol, :rows, :columns, :evolutions, :defaults, :game_settings

  def initialize(input_getter)
    @input_getter = input_getter
    @alive_symbol = 1
    @dead_symbol = 0
    @rows = 10
    @columns = 10
    @evolutions = "infinity"
    @defaults = true
    @game_settings = {rows: @rows, columns: @columns, alive_symbol: @alive_symbol, dead_symbol: @dead_symbol, evolutions: @evolutions}
    @prompts = Prompts.new(@game_settings)
  end

  def settings_prompt
    @prompts.print_messages
    set_defaults_prompt
    set_game_settings if !defaults?
  end

  def set_game_settings
    set_alive_symbol
    set_dead_symbol
    set_number_of_rows
    set_number_of_columns
    set_number_of_evolutions
  end

  def set_alive_symbol
    @alive_symbol = @input_getter.get_alive_symbol
  end

  def set_dead_symbol
    @dead_symbol = @input_getter.get_dead_symbol
  end

  def set_number_of_rows
    @rows = @input_getter.get_number_of_rows
  end

  def set_number_of_columns
    @columns = @input_getter.get_number_of_columns
  end

  def set_number_of_evolutions
    @evolutions = @input_getter.get_number_of_evolutions
  end

  def set_defaults_prompt
    @defaults = @input_getter.get_defaults_prompt_response
  end

  private

  def defaults?
    @defaults
  end

end
