require_relative './cell.rb'

class World
  attr_accessor :board

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @board = Array.new(rows) { Array.new(columns) }
  end

  def generate_dead_cells
    @board = @board.each_with_index.map do |row, x|
      @board[x].each_with_index.map do |cell, y|
        cell = Cell.new(x, y)
      end
    end
  end
  
  def generate_random_cells
    @board = @board.each_with_index.map do |_row, x|
      @board[x].each_with_index.map do |cell, y|
        cell = Cell.new(x, y)
        [cell.revive, cell.die].sample
        cell
      end
    end
  end

  def set_alive_at(x, y)
    @board[x][y].revive
  end

  def kill(x, y) 
    @board[x][y].die
  end

  def get_cell(x, y)
    @board[x][y]
  end

  def neighbors_of(x, y)
    neighbors = []
    neighbors.push(@board[x][y - 1]) # Left
    if y == @columns - 1
      neighbors.push(@board[x][0]) # Wrap from right to left
    else
      neighbors.push(@board[x][y + 1]) # Right
    end
    if x == @rows - 1
      neighbors.push(@board[0][y]) # Wrap from bottom to top
    else
      neighbors.push(@board[x + 1][y]) # Bottom
    end
    if y == @columns - 1 && x == @rows - 1
      neighbors.push(@board[0][0]) # Wrap from bottom right to top right if cell == bottom right corner
    elsif y == @columns - 1
      neighbors.push(@board[x + 1][0]) # Wrap from right to left
    elsif x == @rows - 1
      neighbors.push(@board[0][y + 1]) # Wrap from bottom to top
    else  
      neighbors.push(@board[x + 1][y + 1]) # Bottom Right
    end
    if x == @rows - 1
      neighbors.push(@board[0][y - 1]) # Wrap from bottom to top
    else
      neighbors.push(@board[x + 1][y - 1]) # Bottom left
    end
    neighbors.push(@board[x - 1][y]) # Top
    if y == @columns - 1
      neighbors.push(@board[x - 1][0]) # Wrap from right to left
    else
      neighbors.push(@board[x - 1][y + 1]) # Top Right
    end
    neighbors.push(@board[x - 1][y - 1]) # Top Left
    return neighbors
  end

  def alive_neighbors_of(x, y)
    neighbors = neighbors_of(x, y)
    alive_neighbors = neighbors.filter { |neighbor| neighbor.alive? }
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

  def begin_evolutions
    generation_number = 0
    15.times do
      system "clear"
      puts "Generation #{generation_number += 1}"
      tick
      pp display_board
      sleep(1)
    end
  end

  def tick
    old_world = @board.flatten
    new_world = Array.new(@rows) { Array.new(@columns) }
    old_world.each do |cell|
      new_cell = Cell.new(cell.x, cell.y)
      cell = get_cell(cell.x, cell.y)
      if !cell.alive?
        if revive_at?(cell.x, cell.y)
          new_cell.revive
          new_world[cell.x][cell.y] = new_cell
        end
      elsif cell.alive?
        if alive_next_generation?(cell.x, cell.y)
          new_cell.revive
          new_world[cell.x][cell.y] = new_cell
        end
      else
      end
      new_world[cell.x][cell.y] = new_cell
    end
    @board = new_world
  end

  def display_board
    board = @board.each_with_index.map do |row, x| 
      @board[x].each_with_index.map do |cell, y|
        cell.to_s
      end
    end
  end


end

