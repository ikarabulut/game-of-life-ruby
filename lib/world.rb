#frozen_string_literal: true

class World
  attr_reader :cells

  DEAD = "o"
  ALIVE = "x"

  def initialize(columns, rows)
    @cells = []
    rows.times do |x|
      @cells.push([])
      columns.times do |y|
        @cells[x].push(DEAD) #set everything to dead
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

  def neighbors_of(x,y)
    neighbors = []
    neighbors.push(@cells[x][y - 1])
    neighbors.push(@cells[x][y + 1])
    neighbors.push(@cells[x + 1][y])
    neighbors.push(@cells[x + 1][y + 1])
    neighbors.push(@cells[x + 1][y - 1])
    neighbors.push(@cells[x - 1][y])
    neighbors.push(@cells[x - 1][y + 1])
    neighbors.push(@cells[x - 1][y - 1])
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


end