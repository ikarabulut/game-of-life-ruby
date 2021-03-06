require 'minitest/autorun'
require_relative "../../lib/prompts.rb"

class PromptsTest < MiniTest::Test

  def test_that_messages_are_printed_to_the_terminal
    fake_game_settings = FakeGameSettings.new.game_settings
    prompts = Prompts.new(fake_game_settings)

    expected = <<~PROMPT
      Welcome to Conways Game of Life!
      The defaults for this game are:
      Alive cell: 1
      Dead cell: 0
      Grid Size: 10 X 10
      Evolutions: infinity
      Would you like to play with the defaults? (y/n)
      PROMPT
    
    assert_output(expected) { prompts.print_messages }
  end

end


class FakeGameSettings
  attr_reader :alive_symbol, :dead_symbol, :rows, :columns, :evolutions, :defaults, :game_settings

  def initialize
    @alive_symbol = 1
    @dead_symbol = 0
    @rows = 10
    @columns = 10
    @evolutions = "infinity"
    @defaults = true
    @game_settings = {rows: @rows, columns: @columns, alive_symbol: @alive_symbol, dead_symbol: @dead_symbol, evolutions: @evolutions}
  end

end