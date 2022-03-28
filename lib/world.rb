#frozen_string_literal: true

class World
  attr_accessor :cells

  DEAD = "o"
  ALIVE = "x"

  def initialize(columns, rows) #Columns is Y, Rows is X
    @cells = []
    @columns = columns
    @rows = rows
    rows.times do |x|
      @cells.push([])
      columns.times do |y|
        @cells[x].push([DEAD, ALIVE].sample) #randomize dead & alive cells
      end
    end
  end


  def get_cell(x,y)
    @cells[x][y]
  end
  
 
  def set_alive_at(x,y)
    @cells[x][y] = ALIVE
  end

  def set_dead_at(x,y)
    @cells[x][y] = DEAD
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
  end

  def alive_neighbors_of(x,y)
    alive_neighbors = []
    neighbors_of(x,y).each do |neighbor|
      if neighbor == "x"
        alive_neighbors.push(neighbor)
      end
    end
    return alive_neighbors
  end

  
  
  def alive_next_generation?(x,y)
    if alive_neighbors_of(x,y).length == 2 || alive_neighbors_of(x,y).length == 3
      true
    else
      false
    end
  end

  def revive_at?(x,y)
    if alive_neighbors_of(x,y).length == 3
      true
    else
      false
    end
  end

  def tick
    @cells.each_with_index do |row, x|
      @cells[row].each_with_index do |cell, y|
        if cell == DEAD
          cell = ALIVE if revive_at?(x, y)
        else
          cell = ALIVE if alive_next_generation?(x, y)
        end
      end
    end
  end



end