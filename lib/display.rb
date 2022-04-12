require_relative 'game_settings'
require_relative 'cell'

class Display
  attr_reader :board, :game_settings

  def initialize(game_settings)
    @game_settings = game_settings
    @board = generate_board
  end

  def generate_board
    Array.new(@game_settings.rows) { Array.new(@game_settings.columns) }
  end

  def print_board(world)
    pp display_board(world)
  end

  private

  def display_board(world)
    board = world.each_with_index.map do |row, x| 
      world[x].each_with_index.map do |cell, y|
        cell.alive? ? @game_settings.alive_symbol : @game_settings.dead_symbol
      end
    end
    board = board.map {|row| row.join(', ')} 
  end


end