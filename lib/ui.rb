require_relative './world.rb'

class UI
  attr_reader :alive_symbol, :dead_symbol

  def initialize(input_getter= InputGetter.new)
    @input_getter = input_getter
    @alive_symbol = 1
    @dead_symbol = 0
  end

  def set_alive_symbol
    @alive_symbol = @input_getter.get_alive_symbol
  end

  def set_dead_symbol
    @dead_symbol = @input_getter.get_dead_symbol
  end



end