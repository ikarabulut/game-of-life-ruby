require 'minitest/autorun'
require_relative "../../lib/game_settings.rb"

class GameSettingsTest < MiniTest::Test

  def test_that_the_alive_symbol_can_be_updated
    fake_input_getter = FakeInputGetter.new
    game_settings = GameSettings.new(fake_input_getter)
    game_settings.set_alive_symbol
    assert_equal("o", game_settings.alive_symbol)
  end

  def test_that_the_dead_symbol_can_be_updated
    fake_input_getter = FakeInputGetter.new
    game_settings = GameSettings.new(fake_input_getter)
    game_settings.set_dead_symbol
    assert_equal("x", game_settings.dead_symbol)
  end
  
  def test_that_the_number_of_rows_can_be_updated
    fake_input_getter = FakeInputGetter.new
    game_settings = GameSettings.new(fake_input_getter)
    game_settings.set_number_of_rows
    assert_equal(10, game_settings.rows)
  end

  def test_that_the_number_of_columns_can_be_updated
    fake_input_getter = FakeInputGetter.new
    game_settings = GameSettings.new(fake_input_getter)
    game_settings.set_number_of_columns
    assert_equal(25, game_settings.columns)
  end

  def test_that_the_number_of_evolutions_can_be_updated
    fake_input_getter = FakeInputGetter.new
    game_settings = GameSettings.new(fake_input_getter)
    game_settings.set_number_of_evolutions
    assert_equal(40, game_settings.evolutions)
  end

  def test_that_defaults_can_be_set_to_false
    input = StringIO.new("n")
    fake_input_getter = FakeInputGetter.new(input)
    game_settings = GameSettings.new(fake_input_getter)
    game_settings.set_defaults_prompt
    assert_equal(false, game_settings.defaults)
  end

  def test_that_set_game_settings_is_called_if_defaults_are_false
    input = StringIO.new("n")
    fake_input_getter = FakeInputGetter.new(input)
    game_settings = GameSettings.new(fake_input_getter)

    settings_prompt_mock = MiniTest::Mock.new
    settings_prompt_mock.expect :call, true

    game_settings.stub :set_game_settings, settings_prompt_mock do
      game_settings.settings_prompt
    end
    assert(settings_prompt_mock.verify)
  end

  def test_that_set_game_settings_is_NOT_called_if_defaults_are_true
    input = StringIO.new("y")
    fake_input_getter = FakeInputGetter.new(input)
    game_settings = GameSettings.new(fake_input_getter)

    game_settings.stub(:set_game_settings, -> { raise "set_game_settings was called!" }) do
      game_settings.settings_prompt
    end

  end



end

class FakeInputGetter
  def initialize(input = $stdin)
    @input = input
  end

  def get_alive_symbol
   "o"
  end

  def get_dead_symbol
    "x"
  end

  def get_number_of_rows
    10
  end

  def get_number_of_columns
    25
  end

  def get_number_of_evolutions
    40
  end

  def get_defaults_prompt_response
    @input.gets.chomp() == "y" ? true : false
  end
end