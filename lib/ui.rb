require_relative './world.rb'

class UI
  attr_reader :alive_symbol, :dead_symbol, :rows, :columns

  def initialize(input_getter= InputGetter.new)
    @input_getter = input_getter
    @alive_symbol = 1
    @dead_symbol = 0
    @rows = 10
    @columns = 10
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



end