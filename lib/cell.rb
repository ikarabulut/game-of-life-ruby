class Cell
  attr_reader :x, :y, :alive

  def initialize(x, y, alive)
    @x = x
    @y = y
    @alive = alive
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

end
