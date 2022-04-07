require_relative './world.rb'
require_relative './input_getter.rb'

class UI
  attr_reader :alive_symbol, :dead_symbol, :rows, :columns, :evolutions, :defaults

  def initialize(input_getter= InputGetter.new)
    @input_getter = input_getter
    @alive_symbol = 1
    @dead_symbol = 0
    @rows = 10
    @columns = 10
    @evolutions = "infinity"
    @defaults = true
    display_messages
  end

  def display_messages
    puts display_welcome_message
    puts display_defaults_message
    puts display_defaults_prompt
    set_defaults_prompt
    set_defaults if !defaults?
    puts display_updated_settings if !defaults?
  end

  def set_defaults
    set_alive_symbol
    set_dead_symbol
    set_number_of_rows
    set_number_of_columns
    set_number_of_evolutions
  end

  private

  def defaults?
    @defaults
  end

  def display_welcome_message
    "Welcome to Conways Game of Life!"
  end

  def display_defaults_message
    "The defaults for this game are: \n" +
    "Alive cell: #{@alive_symbol} \n" +
    "Dead cell: #{@dead_symbol} \n" +
    "Grid Size: #{@rows}/#{@columns} \n" +
    "Evolutions: #{@evolutions}"
  end

  def display_updated_settings
    "Your updated game settings are: \n" +
    "Alive cell: #{@alive_symbol} \n" +
    "Dead cell: #{@dead_symbol} \n" +
    "Grid Size: #{@rows}/#{@columns} \n" +
    "Evolutions: #{@evolutions}"
  end

  def display_defaults_prompt
    "Would you like to play with the defaults? (y/n)"
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
  
end
