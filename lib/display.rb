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
    puts display_board(world)
  end

  private

  def display_board(world)
    board = ''
    x = 0
    @game_settings.rows.times do
      y = 0
      board += "\n"
      # board += line
      board += "\n"
      @game_settings.columns.times do
        cell = world[x][y]
        cell = cell.alive? ? @game_settings.alive_symbol : @game_settings.dead_symbol
        board += " #{cell} "
        y += 1
      end
      x += 1
    end
    board += "\n"

    return board
  end


end