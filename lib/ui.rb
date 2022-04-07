require_relative './world.rb'

class UI
  attr_reader :alive_symbol, :dead_symbol, :rows, :columns, :evolutions

  def initialize(input_getter= InputGetter.new)
    @input_getter = input_getter
    @alive_symbol = 1
    @dead_symbol = 0
    @rows = 10
    @columns = 10
    @evolutions = "infinity"
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

  private

  def display_welcome_message
    "Welcome to Conways Game of Life"
  end

  def display_defaults_message
    "The defaults for this game are: \n" +
    "Alive/Dead cells: #{@alive_symbol}/#{@dead_symbol} \n" +
    "Grid Size: #{@rows}/#{@columns} \n" +
    "Evolutions: #{@evolutions}"
  end
  


end