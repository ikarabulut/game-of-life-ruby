require_relative 'game_settings'

class Board
  attr_reader :board

  def initialize(game_settings= GameSettings.new)
    @game_settings = game_settings
    @board = generate_board
  end

  def print_board
    pp display_board
  end

  private

  def generate_board
    Array.new(@game_settings.rows) { Array.new(@game_settings.columns) }
  end

  def display_board
    @board.each_with_index.map do |row, x| 
      @board[x].each_with_index.map do |cell, y|
        cell.alive? ? @game_settings.alive_symbol : @game_settings.dead_symbol
      end
    end
  end


end