#frozen_string_literal: true
require_relative './cell.rb'

class World
  attr_accessor :cells, :cell_objects

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @cells = Array.new(rows) { Array.new(columns) }
  end

  def cell_objects
    @cells.flatten
  end

  def generate_dead_board
    @cells = @cells.each_with_index.map do |row, x|
      @cells[x].each_with_index.map do |cell, y|
        cell = Cell.new(x, y)
      end
    end
  end
  
  def generate_random_board
    @cells = @cells.each_with_index.map do |row, x|
      @cells[x].each_with_index.map do |cell, y|
        cell = Cell.new(x, y)
        cell.status = [0, 1].sample
        cell
      end
    end
  end

  def set_alive_at(x, y)
    @cells[x][y].revive
  end

  def kill(x, y)
    @cells[x][y].die
  end

  def get_cell(x, y)
    @cells[x][y]
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

    neighbors.each do |neighbor|
      if neighbor.alive?
        alive_neighbors.push(neighbor)
      end
    end
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

  def tick
    old_world = cell_objects
    new_world = Array.new(@rows) { Array.new(@columns) }
    old_world.each do |cell|
      new_cell = Cell.new(cell.x, cell.y)
      cell = get_cell(cell.x, cell.y)
      if cell.dead?
        if revive_at?(cell.x, cell.y)
          new_cell.status = 1
          new_world[cell.x][cell.y] = new_cell
        end
      elsif cell.alive?
        if alive_next_generation?(cell.x, cell.y)
          new_cell.status = 1
          new_world[cell.x][cell.y] = new_cell
        end
      else
      end
      new_world[cell.x][cell.y] = new_cell
    end
    @cells = new_world
  end

  def display_board
    board = @cells.each_with_index.map do |row, x| 
      @cells[x].each_with_index.map do |cell, y|
        cell.to_s
      end
    end
  end


end

