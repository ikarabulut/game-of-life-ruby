require_relative 'cell'
require_relative 'display'

class World
  attr_reader :display, :cells, :settings, :system_interaction

  def initialize(display, system_interaction)
    @display = display
    @cells = display.board
    @settings = display.game_settings
    @system_interaction = system_interaction
  end

  def generate_dead_cells
    @cells = @cells.each_with_index.map do |row, x|
      @cells[x].each_with_index.map do |cell, y|
        cell = Cell.new(x, y, false)
      end
    end
  end
  
  def generate_random_cells
    @cells = @cells.each_with_index.map do |row, x|
      @cells[x].each_with_index.map do |cell, y|
        cell = Cell.new(x, y, [true, false].sample)
      end
    end
  end

  def neighbors_of(x, y)
    neighbors = []
    neighbors.push(@cells[x][y - 1]) # Left
    if y == @settings.columns - 1
      neighbors.push(@cells[x][0]) # Wrap from right to left
    else
      neighbors.push(@cells[x][y + 1]) # Right
    end
    if x == @settings.rows - 1
      neighbors.push(@cells[0][y]) # Wrap from bottom to top
    else
      neighbors.push(@cells[x + 1][y]) # Bottom
    end
    if y == @settings.columns - 1 && x == @settings.rows - 1
      neighbors.push(@cells[0][0]) # Wrap from bottom right to top right if cell == bottom right corner
    elsif y == @settings.columns - 1
      neighbors.push(@cells[x + 1][0]) # Wrap from right to left
    elsif x == @settings.rows - 1
      neighbors.push(@cells[0][y + 1]) # Wrap from bottom to top
    else  
      neighbors.push(@cells[x + 1][y + 1]) # Bottom Right
    end
    if x == @settings.rows - 1
      neighbors.push(@cells[0][y - 1]) # Wrap from bottom to top
    else
      neighbors.push(@cells[x + 1][y - 1]) # Bottom left
    end
    neighbors.push(@cells[x - 1][y]) # Top
    if y == @settings.columns - 1
      neighbors.push(@cells[x - 1][0]) # Wrap from right to left
    else
      neighbors.push(@cells[x - 1][y + 1]) # Top Right
    end
    neighbors.push(@cells[x - 1][y - 1]) # Top Left
    return neighbors
  end

  def alive_neighbors_of(x, y)
    neighbors = neighbors_of(x, y)
    alive_neighbors = neighbors.filter { |neighbor| neighbor.alive? }
  end
  
  def alive_next_generation?(x, y)
    (@cells[x][y].alive? && alive_neighbors_of(x, y).length == 2) || alive_neighbors_of(x, y).length == 3
  end

  def tick
    old_world = @cells.flatten
    new_world = @display.generate_board
    old_world.each do |cell|
      if alive_next_generation?(cell.x, cell.y)
        new_cell = Cell.new(cell.x, cell.y, true)
        new_world[cell.x][cell.y] = new_cell
      else
        new_cell = Cell.new(cell.x, cell.y, false)
      end
      new_world[cell.x][cell.y] = new_cell
    end
    @cells = new_world
  end

  def begin_evolutions
    generation_number = 0
    if @settings.evolutions == "infinity"
      while true
        system "clear"
        puts "Generation #{generation_number += 1}"
        tick
        @display.print_board(@cells)
        sleep(1)
      end
    else
      @settings.evolutions.times do
        # SystemInteraction.clear
        system "clear"
        puts "Generation #{generation_number += 1}"
        tick
        @display.print_board(@cells)
        sleep(1)
      end
    end
  end

  def display_single_evolution
    @system_interaction.clear
  end
end

class SystemInteraction
  def clear
    system "clear"
  end

  def print(message)
    puts message
  end

  def sleep(time_in_s)
    sleep time_in_s
  end
end
