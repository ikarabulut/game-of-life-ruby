require_relative './world.rb'

class Cell
  attr_reader :status, :x, :y

  def initialize(x,y, world)
    @x = x
    @y = y
    @world = world
    @status = ["alive","dead"].sample
  end


  def neighbors
    neighbors = []
    neighbors.push(@world.get_cell(self.x, self.y - 1))
    neighbors.push(@world.get_cell(self.x, self.y + 1))
    neighbors.push(@world.get_cell(self.x + 1, self.y))
    neighbors.push(@world.get_cell(self.x + 1, self.y + 1))
    neighbors.push(@world.get_cell(self.x + 1, self.y - 1))
    neighbors.push(@world.get_cell(self.x - 1, self.y))
    neighbors.push(@world.get_cell(self.x - 1, self.y + 1))
    neighbors.push(@world.get_cell(self.x - 1, self.y - 1))
  end

end

  