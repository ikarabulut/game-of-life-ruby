#frozen_string_literal: true
require_relative './cell.rb'

class World
  attr_accessor :cells, :cell_objects

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @cells = Array.new(rows) { Array.new(columns) }
    @cell_objects = []
  end

  def generate_dead_board
    @cells = @cells.each_with_index.map do |row, x|
      @cells[x].each_with_index.map do |cell, y|
        cell = Cell.new(x, y)
      end
    end

    @cell_objects = @cells.flatten
  end
  
  def generate_random_board
    @cells = @cells.each_with_index.map do |row, x|
      @cells[x].each_with_index.map do |cell, y|
        cell = Cell.new(x, y)
        cell.status = [0, 1].sample
        cell
      end
    end

    @cell_objects = @cells.flatten
  end

  def set_alive_at(x, y)
    @cells[x][y].revive
  end

  def neighbors_of(x, y)
    neighbors = []
    neighbors.push(@cells[x][y - 1]) # Left
    if y == @columns - 1
      neighbors.push(@cells[x][0]) # Wrap from right to left
    else
      neighbors.push(@cells[x][y + 1]) # Right
    end
    if x == @rows - 1
      neighbors.push(@cells[0][y]) # Wrap from bottom to top
    else
      neighbors.push(@cells[x + 1][y]) # Bottom
    end
    if y == @columns - 1 && x == @rows - 1
      neighbors.push(@cells[0][0]) # Wrap from bottom right to top right if cell == bottom right corner
    elsif y == @columns - 1
      neighbors.push(@cells[x + 1][0]) # Wrap from right to left
    elsif x == @rows - 1
      neighbors.push(@cells[0][y + 1]) # Wrap from bottom to top
    else  
      neighbors.push(@cells[x + 1][y + 1]) # Bottom Right
    end
    if x == @rows - 1
      neighbors.push(@cells[0][y - 1]) # Wrap from bottom to top
    else
      neighbors.push(@cells[x + 1][y - 1]) # Bottom left
    end
    neighbors.push(@cells[x - 1][y]) # Top
    if y == @columns - 1
      neighbors.push(@cells[x - 1][0]) # Wrap from right to left
    else
      neighbors.push(@cells[x - 1][y + 1]) # Top Right
    end
    neighbors.push(@cells[x - 1][y - 1]) # Top Left
    return neighbors
  end

  def alive_neighbors_of(x, y)
    alive_neighbors = []
    neighbors = neighbors_of(x, y)
    # puts "DEBUG:: #{neighbors} is the array of neighbors"
    
    neighbors.each do |neighbor|
      # puts "DEBUG:: This is #{neighbor.alive?}"
      if neighbor.alive?

        alive_neighbors.push(neighbor)
      end
    end
    # puts "DEBUG:: #{alive_neighbors.length} is the length of alive neighbors"
    return alive_neighbors
  end
  
  def alive_next_generation?(x, y)
    if alive_neighbors_of(x, y).length == 2 || alive_neighbors_of(x, y).length == 3
      true
    else
      false
    end
  end

  def revive_at?(x, y)
    if alive_neighbors_of(x, y).length == 3
      true
    else
      false
    end
  end

  # def start_evolutions
  #   puts "To end the program please hit ctrl + c"
  #   while true
  #     tick
  #     sleep(0.5) 
  #   end
  # end

  
  def tick
    @cell_objects.each do |cell|
      if cell.status == 0
        cell.status = (revive_at?(cell.x, cell.y)) ? 1 : 0
      elsif cell.status == 1
        cell.status = (alive_next_generation?(cell.x, cell.y)) ? 1 : 0
      end
    end
    return @cell_objects
  end

  def display_board
    board = @cells.each_with_index.map do |row, x| 
      @cells[x].each_with_index.map do |cell, y|
        cell.to_s
      end
    end
  end


end

