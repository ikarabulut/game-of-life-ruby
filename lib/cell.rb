require_relative './world.rb'

class Cell
  attr_reader :x, :y, :alive

  def initialize(x, y)
    @x = x
    @y = y
    @alive = false
  end

  def alive?
    @alive
  end

  def revive
    @alive = true
  end

  def die
    @alive = false
  end

  def to_s
    alive? ? 1 : 0
  end
end
